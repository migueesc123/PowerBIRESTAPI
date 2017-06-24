section PowerBIRESTAPI;

//
// OAuth configuration settings
//
client_id = "e25e627f-d7f1-43ca-9ca9-25149783209d";
redirect_uri = "https://oauth.powerbi.com/views/oauthredirect.html";
token_uri = "https://login.windows.net/common/oauth2/token";
authorize_uri = "https://login.windows.net/common/oauth2/authorize";
logout_uri = "https://login.microsoftonline.com/logout.srf";
resourceUri = "https://analysis.windows.net/powerbi/api";

windowWidth = 720;
windowHeight = 1024;

//
// Exported function(s)
//
[DataSource.Kind="PowerBIRESTAPI", Publish="PowerBIRESTAPI.UI"]
shared PowerBIRESTAPI.RefreshHistory = () =>
let
    source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/datasets")),
    value = Table.FromRecords(source[value]),
    refreshHistory = Table.AddColumn( value, "Call", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/datasets/" & [id]&"/refreshes", [
      Headers = [
                #"Content-type" = "application/json"
            ]])) otherwise null),
       ExpandrefreshHistory = Table.ExpandRecordColumn(refreshHistory, "Call", {"value"}, {"value"}),
           ExpandToList = Table.ExpandListColumn(ExpandrefreshHistory, "value"),
    refreshHistoryData = Table.ExpandRecordColumn(ExpandToList, "value", {"id", "refreshType", "startTime", "endTime", "serviceExceptionJson", "status"}, {"id.1", "refreshType", "startTime", "endTime", "serviceExceptionJson", "status"}),
    errorDescriptionJSON = Table.TransformColumns(refreshHistoryData,{{"serviceExceptionJson", Json.Document}}),
    replaceErrors = Table.ReplaceErrorValues(errorDescriptionJSON, {{"serviceExceptionJson", null}}),
    DataType = Table.TransformColumnTypes(replaceErrors,{{"id", type text}, {"name", type text}, {"addRowsAPIEnabled", type logical}, {"configuredBy", type text}, {"id.1", Int64.Type}, {"refreshType", type text}, {"startTime", type datetimezone}, {"endTime", type datetimezone}, {"status", type text}}),
    NameChange = Table.RenameColumns(DataType,{{"id.1", "refreshID"}})
in
    NameChange;

[DataSource.Kind="PowerBIRESTAPI"]
shared PowerBIRESTAPI.GETData = (optional path as text) =>
let
    source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg", [RelativePath = path]))
  
in
    source;

//
// Data Source definition
//
PowerBIRESTAPI = [
    Authentication = [
        OAuth = [
            StartLogin=StartLogin,
            FinishLogin=FinishLogin,
            Refresh=Refresh,
            Logout=Logout
        ]
    ],
    Label = "My Graph Connector"
];

//
// UI Export definition
//
PowerBIRESTAPI.UI = [
    Beta = true,
    ButtonText = { "PowerBIRESTAPI.Feed", "Connect to Graph" },
    SourceImage = PBIAPI.Icons ,
    SourceTypeImage = PBIAPI.Icons 
];

PBIAPI.Icons = [
    Icon16 = { Extension.Contents("PBIAPI16.png"), Extension.Contents("PBIAPI20.png"), Extension.Contents("PBIAPI24.png"), Extension.Contents("PBIAPI32.png") },
    Icon32 = { Extension.Contents("PBIAPI32.png"), Extension.Contents("PBIAPI40.png"), Extension.Contents("PBIAPI48.png"), Extension.Contents("PBIAPI64.png") }
];

//
// OAuth implementation
//
// See the following links for more details on AAD/Graph OAuth:
// * https://docs.microsoft.com/en-us/azure/active-directory/active-directory-protocols-oauth-code 
// * https://graph.microsoft.io/en-us/docs/authorization/app_authorization
//
// StartLogin builds a record containing the information needed for the client
// to initiate an OAuth flow. Note for the AAD flow, the display parameter is
// not used.
//
// resourceUrl: Derived from the required arguments to the data source function
//              and is used when the OAuth flow requires a specific resource to 
//              be passed in, or the authorization URL is calculated (i.e. when
//              the tenant name/ID is included in the URL). In this example, we
//              are hardcoding the use of the "common" tenant, as specified by
//              the 'authorize_uri' variable.
// state:       Client state value we pass through to the service.
// display:     Used by certain OAuth services to display information to the
//              user.
//
// Returns a record containing the following fields:
// LoginUri:     The full URI to use to initiate the OAuth flow dialog.
// CallbackUri:  The return_uri value. The client will consider the OAuth
//               flow complete when it receives a redirect to this URI. This
//               generally needs to match the return_uri value that was
//               registered for your application/client. 
// WindowHeight: Suggested OAuth window height (in pixels).
// WindowWidth:  Suggested OAuth window width (in pixels).
// Context:      Optional context value that will be passed in to the FinishLogin
//               function once the redirect_uri is reached. 
//
StartLogin = (resourceUrl, state, display) =>
    let
        authorizeUrl = authorize_uri & "?" & Uri.BuildQueryString([
            client_id = client_id,  
            redirect_uri = redirect_uri,
            state = state,
            response_type = "code",
            response_mode = "query",
            resource = resourceUri
        ])
    in
        [
            LoginUri = authorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = 720,
            WindowWidth = 1024,
            Context = null
        ];

// FinishLogin is called when the OAuth flow reaches the specified redirect_uri. 
// Note for the AAD flow, the context and state parameters are not used. 
//
// context:     The value of the Context field returned by StartLogin. Use this to 
//              pass along information derived during the StartLogin call (such as
//              tenant ID)
// callbackUri: The callbackUri containing the authorization_code from the service.
// state:       State information that was specified during the call to StartLogin. 
FinishLogin = (context, callbackUri, state) =>
    let
        // parse the full callbackUri, and extract the Query string
        parts = Uri.Parts(callbackUri)[Query],
        // if the query string contains an "error" field, raise an error
        // otherwise call TokenMethod to exchange our code for an access_token
        result = if (Record.HasFields(parts, {"error", "error_description"})) then 
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod("authorization_code", "code", parts[code])
    in
        result;

// Called when the access_token has expired, and a refresh_token is available.
// 
Refresh = (resourceUrl, refresh_token) => TokenMethod("refresh_token", "refresh_token", refresh_token);

Logout = (token) => logout_uri;


// grantType:  Maps to the "grant_type" query parameter.
// tokenField: The name of the query parameter to pass in the code.
// code:       Is the actual code (authorization_code or refresh_token) to send to the service.
TokenMethod = (grantType, tokenField, code) =>
    let
        queryString = [
            client_id = client_id,
            grant_type = grantType,
            redirect_uri = redirect_uri
        ],
        queryWithCode = Record.AddField(queryString, tokenField, code),

        tokenResponse = Web.Contents(token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(queryWithCode)),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"
            ],
            ManualStatusHandling = {400} 
        ]),
        body = Json.Document(tokenResponse),
        result = if (Record.HasFields(body, {"error", "error_description"})) then 
                    error Error.Record(body[error], body[error_description], body)
                 else
                    body
    in
        result;


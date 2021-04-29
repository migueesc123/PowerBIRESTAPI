///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
/////////////                                                                 /////////////
/////////////    Title: Power BI REST API Connector for Power BI              ///////////// 
/////////////    Created by: Miguel Escobar (@EscobarMiguel90)                ///////////// 
/////////////    Website: https://github.com/migueesc123/powerbiRESTAPI       ///////////// 
/////////////                                                                 ///////////// 
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

section PowerBIRESTAPI;

//
// OAuth configuration settings
//

client_id = Text.FromBinary(Extension.Contents("AppID.txt"));  

client_secret = Text.FromBinary(Extension.Contents("ClientSecret.txt"));

redirect_uri = "https://oauth.powerbi.com/views/oauthredirect.html";
token_uri = "https://login.windows.net/common/oauth2/token";
authorize_uri = "https://login.windows.net/common/oauth2/authorize";
logout_uri = "https://login.microsoftonline.com/logout.srf";
resourceUri = "https://analysis.windows.net/powerbi/api";

windowWidth = 720;
windowHeight = 1024;

[DataSource.Kind="PowerBIRESTAPI", Publish="PowerBIRESTAPI.UI"]
shared PowerBIRESTAPI.Navigation = () as table =>
let
        objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {Extension.LoadString("MyWorkspace"),"MyWorkspace",MyWorkspaceNavTable(),"Folder","MyWorkspace",false},
            {Extension.LoadString("AppWorkspace"),"AppWorkspace",AppWorkspacesNavTable(),"Folder","AppWorkspace",false},
            {Extension.LoadString("Gateways"),"Gateways",GatewaysNavTable(),"Folder","Gateways",false},
            {Extension.LoadString("Admin"),"Admin",AdminNavTable(),"Folder","Admin",false},
            {Extension.LoadString("Experimental"),"Experimental",ExperimentalNavTable(),"Folder","Experimental",false},
            {"Functions","Functions",FunctionsNavTable(),"Folder","Functions",false}
        }),
        NavTable = Table.ToNavigationTable(objects,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
        NavTable;

GatewaysNavTable = () as table => 
let
        objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {Extension.LoadString("Gateways"),"Gateways",PowerBIRESTAPI.Gateways(),"Table","Table",true},
            {Extension.LoadString("GatewayDataSources"),"GatewayDataSources",PowerBIRESTAPI.GatewayDataSources(),"Table","Table",true},
            {Extension.LoadString("GatewayDataSourceUsers"),"GatewayDataSourceUsers",PowerBIRESTAPI.GatewayDataSourceUsers(),"Table","Table",true}
        }),
        NavTable = Table.ToNavigationTable(objects,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
        NavTable;

MyWorkspaceNavTable = () as table => 
let
        objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {Extension.LoadString("PersonalDashboards"),"PersonalDashboards",PowerBIRESTAPI.MWDashboards(),"Table","Table",true},
            {Extension.LoadString("PersonalReports"),"PersonalReports",PowerBIRESTAPI.MWReports(),"Table","Table",true},
            {Extension.LoadString("PersonalDatasets"),"PersonalDatasets",PowerBIRESTAPI.MWDatasets(),"Table","Table",true},
            {Extension.LoadString("PersonalApps"),"PersonalApps",PowerBIRESTAPI.MWApps(),"Table","Table",true},
            {Extension.LoadString("PersonalRefreshHistory"),"PersonalRefreshHistory",PowerBIRESTAPI.MWRefreshHistory(),"Table","Table",true}
        }),
        NavTable = Table.ToNavigationTable(objects,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
        NavTable;


AppWorkspacesNavTable = () as table => 
let
        objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {Extension.LoadString("Workspaces"),"Workspaces",PowerBIRESTAPI.GroupsList(),"Table","Table",true},
            {Extension.LoadString("Workspace Users"),"Workspace Users",PowerBIRESTAPI.GroupsUsers(),"Table","Table",true},
            {Extension.LoadString("Dashboards"),"Dashboards",PowerBIRESTAPI.GroupsDashboards(),"Table","Table",true},
            {Extension.LoadString("DashboardTiles"),"DashboardTiles",PowerBIRESTAPI.GroupsDashboardTiles(),"Table","Table",true},
            {Extension.LoadString("Reports"),"Reports",PowerBIRESTAPI.GroupsReports(),"Table","Table",true},
            {Extension.LoadString("Datasets"),"Datasets",PowerBIRESTAPI.GroupsDatasets(),"Table","Table",true},
            {Extension.LoadString("Datasources"),"Datasources",PowerBIRESTAPI.GroupsDatasources(),"Table","Table",true},
            {Extension.LoadString("Dataflows"),"Dataflows",PowerBIRESTAPI.GroupsDataflows(),"Table","Table",true},
            {Extension.LoadString("DataflowDatasources"),"DataflowDatasources",PowerBIRESTAPI.GroupsDataflowDataSources(),"Table","Table",true},
            {Extension.LoadString("RefreshHistory"),"RefreshHistory",PowerBIRESTAPI.AWRefreshHistory(),"Table","Table",true},
            {Extension.LoadString("RefreshSchedule"),"RefreshSchedule",PowerBIRESTAPI.AWRefreshSchedule(),"Table","Table",true}
        }),
        NavTable = Table.ToNavigationTable(objects,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
        NavTable;

AdminNavTable = () as table => 
let
        objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {Extension.LoadString("GroupsAsAdmin"),"GroupsAsAdmin",PowerBIRESTAPI.GroupsAsAdmin(),"Table","Table",true},
            {Extension.LoadString("GroupUsersAsAdmin"),"GroupUsersAsAdmin",PowerBIRESTAPI.GroupUsersAsAdmin(),"Table","Table",true},
            {Extension.LoadString("ReportsAsAdmin"),"ReportsAsAdmin",PowerBIRESTAPI.ReportsAsAdmin(),"Table","Table",true},
            {Extension.LoadString("DashboardsAsAdmin"),"DashboardsAsAdmin",PowerBIRESTAPI.DashboardsAsAdmin(),"Table","Table",true},
            {Extension.LoadString("DataflowsAsAdmin"),"DataflowsAsAdmin",PowerBIRESTAPI.DataflowsAsAdmin(),"Table","Table",true},
            {Extension.LoadString("CapacitiesAsAdmin"),"CapacitiesAsAdmin",PowerBIRESTAPI.CapacitiesAsAdmin(),"Table","Table",true},
            {Extension.LoadString("CapacityRefreshablesAsAdmin"),"CapacityRefreshablesAsAdmin",PowerBIRESTAPI.CapacityRefreshablesAsAdmin(),"Table","Table",true}
        }),
        NavTable = Table.ToNavigationTable(objects, {"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
        NavTable;

ExperimentalNavTable = () as table => 
let
        objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {Extension.LoadString("GatewayDataSourceStatus"),"GatewayDataSourceStatus",PowerBIRESTAPI.GatewayDataSourceStatus(),"Table","Table",true},
            {Extension.LoadString("DatasetDatasourcesAsAdmin"),"DatasetDatasourcesAsAdmin",PowerBIRESTAPI.DatasetDatasourcesAsAdmin(),"Table","Table",true},
            {Extension.LoadString("DataflowDatasourcesAsAdmin"),"DataflowDatasourcesAsAdmin",PowerBIRESTAPI.DataflowDatasourcesAsAdmin(),"Table","Table",true}
        }),
        NavTable = Table.ToNavigationTable(objects,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
        NavTable;

FunctionsNavTable = () as table => 
let
	objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {Extension.LoadString("GETData"),"GETData",PowerBIRESTAPI.GETData,"Function","GETData",true},
            {Extension.LoadString("GETRawData"),"GETRawData",PowerBIRESTAPI.GETRawData,"Function","GETRawData",true},
            {"Event Activity Log", "EventActivityLog", PowerBIRESTAPI.EventActivityLog , "Function", "GetActivityLog", true}
        }),
	NavTable = Table.ForceToNavigationTable(objects, {"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
	NavTable;


PowerBIRESTAPI.EventActivityLog = Value.ReplaceType(ActivityLogPagination,ActivityLogType);

ActivityLogType =type function (
        startdate as ( type date meta[
        Documentation.FieldCaption = "Start Date",
        Documentation.FieldDescription = "Start date of your query"]),
        enddate as ( type date meta[
        Documentation.FieldCaption = "End Date",
        Documentation.FieldDescription = "End date of your query"])) as table meta [                  
        Documentation.Name = "PowerBIRESTAPI.ActivityLog",
        Documentation.LongDescription = "Makes a call to the Power BI REST API Event Activity Log endpoint and returns the full response for the given date range",
        Documentation.Examples = {[
            Description = "Makes a call to the Power BI REST API Event Activity Log endpoint and returns the full response for the given date range",
            Code = "=PowerBIRESTAPI.ActivityLog(#date(2020,1,1), #date(2020,1,9))
            Get the full documentation at  https://msdn.microsoft.com/en-us/library/dn877544.aspx",
            Result = "Table response for all event activity logs in the given date range"
        ]}
    ];

ActivityLogPagination = (startdate as date, enddate as date) =>
    let
    Custom2 = List.Dates(startdate, Number.From(enddate - startdate ) + 1, Duration.From(1) ),
    Custom3 = List.Transform( Custom2, DateTime.From),
    Custom4 = List.Transform(Custom3,each DateTime.ToText(_,"yyyy-MM-ddTHH:mm:ss")),
    Custom5 = List.Transform( Custom3, each _ + #duration(0,23,59,59)),
    Custom6 = List.Transform(Custom5,each DateTime.ToText(_,"yyyy-MM-ddTHH:mm:ss")),
    Custom7 = List.Zip({Custom4, Custom6 } ),
    Custom8 = List.Transform( Custom7, each "https://api.powerbi.com/v1.0/myorg/admin/activityevents?startDateTime='"& _{0} &"'&endDateTime='" & _{1}&"'"),
    GetData = List.Combine( List.Transform( Custom8,  GetActivityLog) ),
    TransformedData = Table.Combine( List.Transform( List.Combine(GetData), each Table.FromRecords({_})) )
in
    TransformedData;

GetActivityLog = (url as text) =>
    let
       Pagination = List.Generate( ()=>
            [Call = Json.Document( Web.Contents(url)), next= try Call[continuationUri] otherwise null, Data = try Call[activityEventEntities] otherwise null],
            each [next] <> null and [Data] <> null, 
            each [Call = Json.Document( Web.Contents([next])), next= try Call[continuationUri] otherwise null, Data = try Call[activityEventEntities] otherwise null],
            each [Data])
            in
                Pagination;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.MWRefreshHistory = () => 
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/datasets", [Headers = [#"Content-type" = "application/json"]])),
	toList = source[value],
	toTable = Table.FromList(toList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	columnNames = Table.ExpandRecordColumn(toTable, "Column1", {"id"}, {"Dataset ID"}),
	refreshHistory = Table.AddColumn(columnNames, "Call", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/datasets/" & [Dataset ID]&"/refreshes", [Headers = [#"Content-type" = "application/json"]])) otherwise null),
    expandCall = Table.ExpandRecordColumn(refreshHistory, "Call", {"value"}, {"value"}),
    expandValue = Table.ExpandListColumn(expandCall, "value"),
    expandColumns = Table.ExpandRecordColumn(expandValue, "value", {"id", "refreshType", "startTime", "endTime", "status", "requestId", "serviceExceptionJson"}, {"Refresh ID", "Refresh Type", "Start Time", "End Time", "Status", "Request ID", "serviceExceptionJson"}),
    parseJSON = Table.TransformColumns(expandColumns,{{"serviceExceptionJson", Json.Document}}),
    replaceErrors = Table.ReplaceErrorValues(parseJSON, {{"serviceExceptionJson", null}}),
    expandServiceException = Table.ExpandRecordColumn(replaceErrors, "serviceExceptionJson", {"errorCode", "errorDescription"}, {"Error Code", "Error Description"}),
    filterNoRefreshes = Table.SelectRows(expandServiceException, each [Refresh ID] <> null and [Refresh ID] <> ""),
    changeType = Table.TransformColumnTypes(filterNoRefreshes,{{"Dataset ID", type text}, {"Refresh ID", Int64.Type}, {"Refresh Type", type text}, {"Status", type text}, {"Request ID", type text}, {"Error Code", type text}, {"Error Description", type text}, {"Start Time", type datetimezone}, {"End Time", type datetimezone}}),
    addDuration = Table.AddColumn(changeType, "Duration In Minutes", each Duration.TotalMinutes([End Time]-[Start Time]), type number)
in
    addDuration;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.AWRefreshHistory = () =>
let
	source = PowerBIRESTAPI.GroupsDatasets(),
	value = Table.SelectColumns( source, {"Workspace ID","Dataset ID"}),
	refreshHistory = Table.AddColumn( value, "Refresh", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/groups/"&[Workspace ID]&"/datasets/"&[Dataset ID]&"/refreshes",[Headers=[#"Content-type" = "application/json"]])) otherwise null),
	expandRefresh = Table.ExpandRecordColumn(refreshHistory, "Refresh", {"value"}, {"value"}),
	expandList = Table.ExpandListColumn(expandRefresh, "value"),
	expandRecord = Table.ExpandRecordColumn(expandList, "value", {"id", "refreshType", "startTime", "endTime", "serviceExceptionJson", "status", "requestId"}, {"Refresh ID", "Refresh Type", "Start Time", "End Time", "serviceExceptionJson", "Status", "Request ID"}),
	parseJSON = Table.TransformColumns(expandRecord,{{"serviceExceptionJson", Json.Document}}),
	replaceErrors = Table.ReplaceErrorValues(parseJSON, {{"serviceExceptionJson", null}}),
	expandServiceException = Table.ExpandRecordColumn(replaceErrors, "serviceExceptionJson", {"errorCode", "errorDescription"}, {"Error Code", "Error Description"}),
	filterNoRefresh = Table.SelectRows(expandServiceException, each ([Refresh ID] <> null)),
	changeType = Table.TransformColumnTypes(filterNoRefresh,{{"Refresh ID", Int64.Type}, {"Refresh Type", type text}, {"Error Code", type text}, {"Error Description", type text}, {"Status", type text}, {"Request ID", type text}, {"Start Time", type datetimezone}, {"End Time", type datetimezone}}),
    addDuration = Table.AddColumn(changeType, "Duration In Minutes", each Duration.TotalMinutes([End Time]-[Start Time]), type number)
in
    addDuration;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.AWRefreshSchedule = () =>
let
	source = PowerBIRESTAPI.GroupsDatasets(),
	value = Table.SelectColumns( source, {"Workspace ID","Dataset ID"}),
	refreshSchedule = Table.AddColumn( value, "RefreshSchedule", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/groups/"&[Workspace ID]&"/datasets/"&[Dataset ID]&"/refreshSchedule",[Headers=[#"Content-type" = "application/json"]])) otherwise null),
	expand = Table.ExpandRecordColumn(refreshSchedule, "RefreshSchedule", {"days", "times", "enabled", "localTimeZoneId", "notifyOption"}, {"Days", "Times", "Scheduled Refresh Enabled", "Time Zone", "Notify Option"}),
	extractDays = Table.TransformColumns(expand, {"Days", each Text.Combine(List.Transform(_, Text.From), ","), type text}),
	extractTimes = Table.TransformColumns(extractDays, {"Times", each Text.Combine(List.Transform(_, Text.From), ","), type text}),
	removeNoRefresh = Table.RemoveRowsWithErrors(extractTimes, {"Days"}),
	changeType = Table.TransformColumnTypes(removeNoRefresh,{{"Notify Option", type text}, {"Time Zone", type text}, {"Scheduled Refresh Enabled", type logical}, {"Times", type text}, {"Days", type text}, {"Dataset ID", type text}, {"Workspace ID", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
shared PowerBIRESTAPI.GETData = Value.ReplaceType(GETData, GETDataType);

	GETDataType = type function (
        optional path as ( type text meta[
        Documentation.FieldCaption = "url Path",
        Documentation.FieldDescription = "Text string to be added to the https://api.powerbi.com/v1.0/myorg"])) as table meta [                  
        Documentation.Name = "PowerBIRESTAPI.GETData",
        Documentation.LongDescription = "Makes a call to the Power BI REST API and returns the JSON response",
        Documentation.Examples = {[
            Description = "Returns raw data from any of the https://api.powerbi.com/v1.0/myorg endpoints. ",
            Code = "=PowerBIRESTAPI.GETData(""datasets"")
            Get the full documentation at  https://msdn.microsoft.com/en-us/library/dn877544.aspx",
            Result = "JSON response for all the datasets in the Personal Workspace of the authenticated user."
        ]}
    ]; 

GETData = (optional path as text) =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg", [RelativePath = path]))
in
	source;

[DataSource.Kind="PowerBIRESTAPI"]
shared PowerBIRESTAPI.GETRawData = Value.ReplaceType(GETRawData, GETRawDataType);

	GETRawDataType = type function (
        optional path as ( type text meta[
        Documentation.FieldCaption = "url Path",
        Documentation.FieldDescription = "Text string to be added to the https://api.powerbi.com/v1.0/myorg"])) as table meta [                  
        Documentation.Name = "PowerBIRESTAPI.GETRawData",
        Documentation.LongDescription = "Makes a call to the Power BI REST API and returns the raw response",
        Documentation.Examples = {[
            Description = "Returns raw data from any of the https://api.powerbi.com/v1.0/myorg endpoints. ",
            Code = "=PowerBIRESTAPI.GETData(""datasets"")
            Get the full documentation at  https://msdn.microsoft.com/en-us/library/dn877544.aspx",
            Result = "Raw response for all the datasets in the Personal Workspace of the authenticated user."
        ]}
    ]; 

GETRawData = (optional path as text) => let source = Web.Contents("https://api.powerbi.com/v1.0/myorg",[RelativePath = path,ManualStatusHandling = {400}]) in source;

[DataSource.Kind="PowerBIRESTAPI"]
shared	PowerBIRESTAPI.GroupsList = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups", [Headers = [#"Content-type" = "application/json"]])),
	toList = source[value],
	toTable = Table.FromList(toList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    expandColumns = Table.ExpandRecordColumn(toTable, "Column1", {"id", "isReadOnly", "isOnDedicatedCapacity", "name", "capacityId"}, {"Workspace ID", "Is Read Only", "Is On Dedicated Capacity", "Workspace Name", "Capacity ID"}),
    changeType = Table.TransformColumnTypes(expandColumns,{{"Workspace ID", type text}, {"Is Read Only", type logical}, {"Is On Dedicated Capacity", type logical}, {"Workspace Name", type text}, {"Capacity ID", type text}})
in
    changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsUsers = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups", [Headers = [#"Content-type" = "application/json"]])),
	toList = source[value],
	toTable = Table.FromList(toList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	columnNames = Table.ExpandRecordColumn(toTable, "Column1", {"id"}, {"Workspace ID"}),
	members = Table.AddColumn(columnNames, "Users", each try Table.FromRecords(Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups/" & Text.From([Workspace ID])&"/users"))[value],{"emailAddress","groupUserAccessRight","displayName","identifier","principalType"},MissingField.UseNull) otherwise null ),
	expand = Table.ExpandTableColumn(members, "Users", {"emailAddress", "groupUserAccessRight", "displayName", "identifier", "principalType"}, {"Email Address", "User Role", "User Display Name", "User Identifier", "User Principal Type"}),
	changeType = Table.TransformColumnTypes(expand,{{"Workspace ID", type text}, {"Email Address", type text}, {"User Role", type text}, {"User Display Name", type text}, {"User Identifier", type text}, {"User Principal Type", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
shared	PowerBIRESTAPI.GroupsDatasets = () =>
let
	source = PowerBIRESTAPI.GroupsList(),
	value = Table.SelectColumns(source, {"Workspace ID"}),
	members = Table.AddColumn(value, "Datasets", each try Table.FromRecords(Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups/" & Text.From([Workspace ID])&"/datasets"))[value],{"id","name","addRowsAPIEnabled","configuredBy","isRefreshable","isEffectiveIdentityRequired","isEffectiveIdentityRolesRequired","isOnPremGatewayRequired","targetStorageMode"},MissingField.UseNull) otherwise null ),
    expandColumns = Table.ExpandTableColumn(members, "Datasets", {"id", "name", "addRowsAPIEnabled", "configuredBy", "isRefreshable", "isEffectiveIdentityRequired", "isEffectiveIdentityRolesRequired", "isOnPremGatewayRequired", "targetStorageMode"}, {"Dataset ID", "Dataset Name", "Add Rows API Enabled", "Dataset Configured By", "Is Refreshable", "Is Effective Identity Required", "Is Effective Identity Roles Required", "Is On Prem Gateway Required", "Target Storage Mode"}),
    changeType = Table.TransformColumnTypes(expandColumns,{{"Dataset ID", type text}, {"Dataset Name", type text}, {"Add Rows API Enabled", type logical}, {"Dataset Configured By", type text}, {"Is Refreshable", type logical}, {"Is Effective Identity Required", type logical}, {"Is Effective Identity Roles Required", type logical}, {"Is On Prem Gateway Required", type logical}, {"Target Storage Mode", type text}}),
    filterNoDatasets = Table.SelectRows(changeType, each ([Dataset ID] <> null))
in
    filterNoDatasets;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.MWDatasets = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/datasets"))[value],
    convertToTable = Table.FromList(source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    expandColumn = Table.ExpandRecordColumn(convertToTable, "Column1", {"id", "name", "addRowsAPIEnabled", "configuredBy", "isRefreshable", "isEffectiveIdentityRequired", "isEffectiveIdentityRolesRequired", "isOnPremGatewayRequired", "targetStorageMode"}, {"Dataset ID", "Dataset Name", "Add Rows API Enabled", "Dataset Configured By", "Is Refreshable", "Is Effective Identity Required", "Is Effective Identity Roles Required", "Is On Prem Gateway Required", "Target Storage Mode"}),
    filterNoDataset = Table.SelectRows(expandColumn, each [Dataset ID] <> null),
    changeType = Table.TransformColumnTypes(filterNoDataset,{{"Dataset ID", type text}, {"Dataset Name", type text}, {"Add Rows API Enabled", type logical}, {"Dataset Configured By", type text}, {"Is Refreshable", type logical}, {"Is Effective Identity Required", type logical}, {"Is Effective Identity Roles Required", type logical}, {"Is On Prem Gateway Required", type logical}, {"Target Storage Mode", type text}})
in
    changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsReports = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups", [Headers = [#"Content-type" = "application/json"]])),
	toList = source[value],
	toTable = Table.FromList(toList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	columnNames = Table.ExpandRecordColumn(toTable, "Column1", {"id"}, {"Workspace ID"}),
	members = Table.AddColumn( columnNames, "Reports", each try Table.FromRecords(Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups/" & Text.From([Workspace ID])&"/reports") )[value],{"id", "name", "reportType", "webUrl", "embedUrl", "datasetId"},MissingField.UseNull ) otherwise null ),
	expand = Table.ExpandTableColumn(members, "Reports", {"id", "name", "reportType", "webUrl", "embedUrl", "datasetId"}, {"Report ID", "Report Name", "Report Type", "Report Web URL", "Report Embed URL", "Dataset ID"}),
	filterNoReports = Table.SelectRows(expand, each ([Report ID] <> null)),
	ChangeType = Table.TransformColumnTypes(filterNoReports,{{"Workspace ID", type text}, {"Report ID", type text}, {"Report Name", type text}, {"Report Type", type text}, {"Report Web URL", type text}, {"Report Embed URL", type text}, {"Dataset ID", type text}})
in
	ChangeType;

[DataSource.Kind="PowerBIRESTAPI"]
	shared PowerBIRESTAPI.MWReports = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/reports"))[value],
    convertToTable = Table.FromList(source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    expandColumns = Table.ExpandRecordColumn(convertToTable, "Column1", {"id", "reportType", "name", "webUrl", "embedUrl", "isOwnedByMe", "datasetId", "appId"}, {"Report ID", "Report Type", "Report Name", "Web URL", "Embed URL", "Is Owned By Me", "Dataset ID", "App Id"}),
    changeType = Table.TransformColumnTypes(expandColumns,{{"Report ID", type text}, {"Report Type", type text}, {"Report Name", type text}, {"Web URL", type text}, {"Embed URL", type text}, {"Is Owned By Me", type logical}, {"Dataset ID", type text}, {"App Id", type text}})
in
    changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsDashboards = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups", [Headers = [#"Content-type" = "application/json"]])),
	toList = source[value],
	toTable = Table.FromList(toList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	columnNames = Table.ExpandRecordColumn(toTable, "Column1", {"id"}, {"Workspace ID"}),
	members = Table.AddColumn(columnNames, "Dashboards", each try Table.FromRecords(Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups/" & Text.From([Workspace ID])&"/dashboards"))[value],{"id","displayName","embedUrl","isReadOnly"},MissingField.UseNull) otherwise null ),
	expandDashboards = Table.ExpandTableColumn(members, "Dashboards", {"id","displayName","embedUrl","isReadOnly"}, {"Dashboard ID", "Dashboard Name", "Dashboard Embed URL", "Is Read Only"}),
	FilterEmptyWorkspaces = Table.SelectRows(expandDashboards, each ([Dashboard ID] <> null)),
	changeType = Table.TransformColumnTypes(FilterEmptyWorkspaces,{{"Workspace ID", type text}, {"Dashboard ID", type text}, {"Dashboard Name", type text}, {"Dashboard Embed URL", type text}, {"Is Read Only", type logical}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.MWApps = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/apps"))[value],
    toTable = Table.FromList(source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    expandColumns = Table.ExpandRecordColumn(toTable, "Column1", {"id", "name", "lastUpdate", "description", "publishedBy"}, {"App ID", "App Name", "App Last Updated", "App Description", "App Published By"}),
    changeType = Table.TransformColumnTypes(expandColumns,{{"App ID", type text}, {"App Name", type text}, {"App Description", type text}, {"App Published By", type text}, {"App Last Updated", type datetimezone}})
in
    changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsDashboardTiles = () =>
let
	source = PowerBIRESTAPI.GroupsDashboards(),
	value = Table.SelectColumns( source, {"Workspace ID","Dashboard ID"}),
	datasources = Table.AddColumn( value, "Tiles", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/groups/"&[Workspace ID]&"/dashboards/"&[Dashboard ID]&"/tiles",[Headers=[#"Content-type" = "application/json"]])) otherwise null),
	toList = Table.ExpandRecordColumn(datasources, "Tiles", {"value"}, {"Tiles.value"}),
	expandList = Table.ExpandListColumn(toList, "Tiles.value"),
	expandFields = Table.ExpandRecordColumn(expandList, "Tiles.value", {"id", "reportId", "datasetId", "title", "subTitle", "embedUrl", "action"}, {"Dashboard Tile ID", "Report ID", "Dataset ID", "Tile Title", "Tile Subtitle", "Tile Embed URL", "Tile Action"}),
	expandAction = Table.ExpandRecordColumn(expandFields, "Tile Action", {"openUrl"}, {"openUrl"}),
	expandURL = Table.ExpandRecordColumn(expandAction, "openUrl", {"targetUrl"}, {"Target URL"}),
	changeType = Table.TransformColumnTypes(expandURL,{{"Workspace ID", type text}, {"Dashboard ID", type text}, {"Dashboard Tile ID", type text}, {"Report ID", type text}, {"Dataset ID", type text}, {"Tile Title", type text}, {"Tile Subtitle", type text}, {"Tile Embed URL", type text}, {"Target URL", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	shared PowerBIRESTAPI.MWDashboards = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/dashboards"))[value],
    convertToTable = Table.FromList(source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    expandColumn = Table.ExpandRecordColumn(convertToTable, "Column1", {"id", "displayName", "isReadOnly", "embedUrl", "dataClassification", "appId"}, {"Dashboard ID", "Dashboard Name", "Is Read Only", "Embed URL", "Data Classification", "App ID"}),
    changeType = Table.TransformColumnTypes(expandColumn,{{"App ID", type text}, {"Data Classification", type text}, {"Embed URL", type text}, {"Is Read Only", type logical}, {"Dashboard Name", type text}, {"Dashboard ID", type text}})
in
    changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsDatasources = () =>
let
	source = PowerBIRESTAPI.GroupsDatasets(),
	value = Table.SelectColumns( source, {"Workspace ID","Dataset ID"}),
	datasources = Table.AddColumn( value, "Datasources", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/groups/"&[Workspace ID]&"/datasets/"&[Dataset ID]&"/datasources",[Headers=[#"Content-type" = "application/json"]])) otherwise null),
	expandDatasources = Table.ExpandRecordColumn(datasources, "Datasources", {"value"}, {"value"}),
	toList = Table.ExpandListColumn(expandDatasources, "value"),
	expandRecords = Table.ExpandRecordColumn(toList, "value", {"datasourceId", "gatewayId", "datasourceType", "connectionDetails"}, {"Datasource ID", "Gateway ID","Datasource Type", "connectionDetails"}),
	expandConnectionDetails = Table.ExpandRecordColumn(expandRecords, "connectionDetails", {"url", "path", "kind", "server", "database", "connectionString", "emailAddress", "domain"}, {"url", "path", "kind", "server", "database", "connectionString", "emailAddress", "domain"}),
	ServerAndDB = Table.AddColumn(expandConnectionDetails,"Server And Database", each [server]&" | "&[database]),
	ExtensionFull = Table.AddColumn(ServerAndDB, "ExtensionFull", each [kind] & " | " & [path]),
	ConnectionInfo = Table.AddColumn(ExtensionFull, "Connection Information", each if [Datasource Type] = "AnalysisServices" then [Server And Database] 
        else if [Datasource Type] = "ODBC" then [connectionString] 
        else if [Datasource Type] = "Sql" then [Server And Database] 
        else if [Datasource Type] = "DB2" then [Server And Database] 
        else if [Datasource Type] = "File" then [path] 
        else if [Datasource Type] = "ActiveDirectory" then [domain] 
        else if [Datasource Type] = "Folder" then [path] 
        else if [Datasource Type] = "Web" then [url] 
        else if [Datasource Type] = "MySql" then [Server And Database] 
        else if [Datasource Type] = "OData" then [url] 
        else if [Datasource Type] = "SharePointList" then [url] 
        else if [Datasource Type] = "Extension" then [ExtensionFull] 
        else if [Datasource Type] = "Oracle" then [server] 
        else if [Datasource Type] = "Teradata" then [server] 
        else if [Datasource Type] = "Exchange" then [emailAddress] 
        else if [Datasource Type] = "OleDb" then [connectionString] 
        else "Requires Mapping"),
	filterNoDatasource = Table.SelectRows(ConnectionInfo, each ([Datasource Type] <> null)),
	removeColumns = Table.RemoveColumns(filterNoDatasource,{"url", "path", "kind", "server", "database", "connectionString", "emailAddress", "domain", "Server And Database", "ExtensionFull"}),
	ChangeType = Table.TransformColumnTypes(removeColumns,{{"Connection Information", type text}, {"Datasource Type", type text}, {"Gateway ID", type text}, {"Datasource ID", type text}, {"Dataset ID", type text}, {"Workspace ID", type text}})
in
	ChangeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsDataflows = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups", [Headers = [#"Content-type" = "application/json"]])),
	toList = source[value],
	toTable = Table.FromList(toList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	columnNames = Table.ExpandRecordColumn(toTable, "Column1", {"id"}, {"Workspace ID"}),
	members = Table.AddColumn(columnNames, "Dataflows", each try Table.FromRecords(Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/groups/" & Text.From([Workspace ID])&"/dataflows") )[value] ) otherwise null ),
	expand = Table.ExpandTableColumn(members, "Dataflows", {"objectId", "name", "description", "configuredBy"}, {"Dataflow ID", "Dataflow Name", "Dataflow Description", "Dataflow Configured By"}),
	filterNoDataflow = Table.SelectRows(expand, each ([Dataflow ID] <> null)),
	changeType = Table.TransformColumnTypes(filterNoDataflow,{{"Workspace ID", type text}, {"Dataflow ID", type text}, {"Dataflow Name", type text}, {"Dataflow Description", type text}, {"Dataflow Configured By", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsDataflowDataSources = () =>
let
	source = PowerBIRESTAPI.GroupsDataflows(),
	value = Table.SelectColumns( source, {"Workspace ID","Dataflow ID"}),
	datasources = Table.AddColumn( value, "Datasources", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/groups/"&[Workspace ID]&"/dataflows/"&[Dataflow ID]&"/datasources",[Headers=[#"Content-type" = "application/json"]])) otherwise null),
	expandDatasources = Table.ExpandRecordColumn(datasources, "Datasources", {"value"}, {"value"}),
	toList = Table.ExpandListColumn(expandDatasources, "value"),
	expandRecords = Table.ExpandRecordColumn(toList, "value", {"datasourceId", "gatewayId", "datasourceType", "connectionDetails"}, {"Datasource ID", "Gateway ID","Datasource Type", "connectionDetails"}),
	expandConnectionDetails = Table.ExpandRecordColumn(expandRecords, "connectionDetails", {"url", "extensionDataSourcePath", "extensionDataSourceKind", "server", "database", "connectionString", "sharePointSiteUrl","emailAddress", "domain","path"}, {"url", "extensionDataSourcePath", "extensionDataSourceKind", "server", "database", "connectionString","sharePointSiteUrl", "emailAddress", "domain","path"}),
	ServerAndDB = Table.AddColumn(expandConnectionDetails,"Server And Database", each [server]&" | "&[database]),
	ExtensionFull = Table.AddColumn(ServerAndDB, "ExtensionFull", each [extensionDataSourceKind] & " | " & [extensionDataSourcePath]),
	ConnectionInfo = Table.AddColumn(ExtensionFull, "Connection Information", each if [Datasource Type] = "AnalysisServices" then [Server And Database] 
        else if [Datasource Type] = "ODBC" then [connectionString] 
        else if [Datasource Type] = "Sql" then [Server And Database] 
        else if [Datasource Type] = "DB2" then [Server And Database] 
        else if [Datasource Type] = "File" then [path] 
        else if [Datasource Type] = "ActiveDirectory" then [domain] 
        else if [Datasource Type] = "Folder" then [path] 
        else if [Datasource Type] = "Web" then [url] 
        else if [Datasource Type] = "MySql" then [Server And Database] 
        else if [Datasource Type] = "OData" then [url] 
        else if [Datasource Type] = "SharePointList" then [sharePointSiteUrl] 
        else if [Datasource Type] = "Extension" then [ExtensionFull] 
        else if [Datasource Type] = "Teradata" then [server] 
        else if [Datasource Type] = "Oracle" then [server] 
        else if [Datasource Type] = "Exchange" then [emailAddress] 
        else if [Datasource Type] = "OleDb" then [connectionString] 
        else "Requires Mapping"),
	filterNoDatasource = Table.SelectRows(ConnectionInfo, each ([Datasource Type] <> null)),
	removeColumns = Table.RemoveColumns(filterNoDatasource,{"url", "path", "extensionDataSourcePath", "extensionDataSourceKind", "server", "database", "connectionString", "sharePointSiteUrl","emailAddress", "domain", "Server And Database", "ExtensionFull"}),
	ChangeType = Table.TransformColumnTypes(removeColumns,{{"Connection Information", type text}, {"Datasource Type", type text}, {"Gateway ID", type text}, {"Datasource ID", type text}, {"Dataflow ID", type text}, {"Workspace ID", type text}})
in
	ChangeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.Gateways = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/gateways"))[value],
	ToTable = Table.FromRecords(source),
	columnNames = Table.RenameColumns(ToTable,{{"id", "Gateway ID"}, {"name", "Gateway Name"}}),
	members = Table.AddColumn( columnNames, "GW", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/gateways/" & [Gateway ID], [Headers = [#"Content-type" = "application/json"]])) otherwise null),
	ExpandStatus= Table.ExpandRecordColumn(members, "GW", {"gatewayStatus"}, {"Gateway Status"}),
	ConvertToJSON = Table.TransformColumns(ExpandStatus,{{"gatewayAnnotation", Json.Document}}),
	ExpandAnnotation = Table.ExpandRecordColumn(ConvertToJSON, "gatewayAnnotation", {"gatewayContactInformation", "gatewayVersion", "gatewayMachine", "gatewayDepartment"}, {"Gateway Contact Information", "Gateway Version", "Gateway Machine Name", "Gateway Department"}),
	ExpandContact = Table.TransformColumns(ExpandAnnotation, {"Gateway Contact Information", each Text.Combine(List.Transform(_, Text.From)), type text}),
    RemoveColumns= Table.RemoveColumns(ExpandContact,{"gatewayId", "type", "publicKey"}),
	ChangeType = Table.TransformColumnTypes(RemoveColumns,{{"Gateway ID", type text}, {"Gateway Name", type text}, {"Gateway Contact Information", type text}, {"Gateway Version", type text}, {"Gateway Machine Name", type text}, {"Gateway Department", type text}, {"Gateway Status", type text}})
in
	ChangeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GatewayDataSourceStatus = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/gateways"))[value],
	ToTable = Table.FromRecords(source),
	columnNames = Table.RenameColumns(ToTable,{{"id", "Gateway ID"}}),
	members = Table.AddColumn(columnNames, "Gateway Data Sources", each try Table.FromRecords(Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/gateways/" & Text.From([Gateway ID])&"/datasources") )[value] ) otherwise null ),
	Columns = Table.SelectColumns(members,{"Gateway ID", "Gateway Data Sources"}),
	Expanded = Table.ExpandTableColumn(Columns, "Gateway Data Sources", {"id"}, {"Gateway Datasource ID"}),
	datasources = Table.AddColumn(Expanded, "Status", each try Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/gateways/"&[Gateway ID]&"/datasources/"&[Gateway Datasource ID]&"/status",[ManualStatusHandling = {400}]),65001) otherwise null),
    filterToErrors = Table.SelectRows(datasources, each ([Status] <> null)),
    expandStatus = Table.ExpandRecordColumn(filterToErrors, "Status", {"error"}, {"error"}),
    expandError = Table.ExpandRecordColumn(expandStatus, "error", {"code", "pbi.error"}, {"Error Code", "error.pbi.error"}),
    expandErrorDetail = Table.ExpandRecordColumn(expandError, "error.pbi.error", {"details"}, {"details"}),
    expandErrorDetailList = Table.ExpandListColumn(expandErrorDetail, "details"),
    expandErrorDetailValues = Table.ExpandRecordColumn(expandErrorDetailList, "details", {"code", "detail"}, {"error.pbi.error.details.code", "error.pbi.error.details.detail"}),
    filterToMessages = Table.SelectRows(expandErrorDetailValues, each ([error.pbi.error.details.code] = "DM_ErrorDetailNameCode_UnderlyingErrorMessage")),
    expandErrorDetailValue = Table.ExpandRecordColumn(filterToMessages, "error.pbi.error.details.detail", {"value"}, {"Error Value"}),
    removeColumns = Table.SelectColumns(expandErrorDetailValue,{"Gateway ID", "Gateway Datasource ID", "Error Code", "Error Value"}),
    changeType = Table.TransformColumnTypes(removeColumns,{{"Gateway ID", type text}, {"Gateway Datasource ID", type text}, {"Error Value", type text}, {"Error Code", type text}})
in
    changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GatewayDataSources = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/gateways"))[value],
	ToTable = Table.FromRecords(source),
	columnNames = Table.RenameColumns(ToTable,{{"id", "Gateway ID"}}),
	members = Table.AddColumn(columnNames, "Gateway Data Sources", each try Table.FromRecords(Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/gateways/" & Text.From([Gateway ID])&"/datasources") )[value] ) otherwise null ),
	Columns = Table.SelectColumns(members,{"Gateway ID", "Gateway Data Sources"}),
	Expanded = Table.ExpandTableColumn(Columns, "Gateway Data Sources", {"id", "datasourceType", "connectionDetails", "credentialType","datasourceName"}, {"Gateway Datasource ID", "Data Source Type", "Connection Details", "Credential Type", "Data Source Name"}),
	ConvertConnectionToJSON = Table.AddColumn(Expanded, "Connections", each Json.Document([Connection Details])),
	ExpandedConnection = Table.ExpandRecordColumn(ConvertConnectionToJSON, "Connections", {"url", "connectionString", "server", "database","extensionDataSourceKind","extensionDataSourcePath","sharePointSiteUrl","domain","path"}, {"URL", "Connection String", "Server Name", "Database Name","extensionDataSourceKind","extensionDataSourcePath","sharePointSiteUrl","domain","path"}),
	ServerAndDB = Table.AddColumn(ExpandedConnection, "Server And Database", each [Server Name]&" | "&[Database Name]),
	ExtensionFull = Table.AddColumn(ServerAndDB, "ExtensionFull", each [extensionDataSourceKind] & " | " & [extensionDataSourcePath]), 
	ConnectionInfo = Table.AddColumn(ExtensionFull, "Connection Information", each if [Data Source Type] = "AnalysisServices" then [Server And Database] 
        else if [Data Source Type] = "ODBC" then [Connection String] 
        else if [Data Source Type] = "Sql" then [Server And Database] 
        else if [Data Source Type] = "DB2" then [Server And Database]
        else if [Data Source Type] = "File" then [path] 
        else if [Data Source Type] = "ActiveDirectory" then [domain]
        else if [Data Source Type] = "Folder" then [path] 
        else if [Data Source Type] = "Web" then [URL] 
        else if [Data Source Type] = "MySql" then [Server And Database] 
        else if [Data Source Type] = "OData" then [URL] 
        else if [Data Source Type] = "SharePointList" then [sharePointSiteUrl] 
        else if [Data Source Type] = "Extension" then [ExtensionFull] 
        else if [Data Source Type] = "Oracle" then [Server Name] 
        else if [Data Source Type] = "Teradata" then [Server Name] 
        else if [Data Source Type] = "PostgreSql" then [Server Name] 
        else if [Data Source Type] = "OleDb" then [Connection String] 
        else "Requires Mapping"),
	filterNoDatasource = Table.SelectRows(ConnectionInfo, each ([Gateway Datasource ID] <> null)),
	RemoveColumns = Table.RemoveColumns(filterNoDatasource,{"Connection Details", "URL", "Connection String", "Server Name", "Database Name", "extensionDataSourceKind", "extensionDataSourcePath", "sharePointSiteUrl", "domain", "path", "Server And Database", "ExtensionFull"}),
	ChangeType = Table.TransformColumnTypes(RemoveColumns,{{"Gateway ID", type text}, {"Gateway Datasource ID", type text}, {"Data Source Type", type text}, {"Credential Type", type text}, {"Data Source Name", type text}, {"Connection Information", type text}})
in
	ChangeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GatewayDataSourceUsers = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/gateways"))[value],
	ToTable = Table.FromRecords(source),
	columnNames = Table.RenameColumns(ToTable,{{"id", "Gateway ID"}}),
	members = Table.AddColumn(columnNames, "Gateway Data Sources", each try Table.FromRecords(Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/gateways/" & Text.From([Gateway ID])&"/datasources") )[value] ) otherwise null ),
	Columns = Table.SelectColumns(members,{"Gateway ID", "Gateway Data Sources"}),
	Expanded = Table.ExpandTableColumn(Columns, "Gateway Data Sources", {"id"}, {"Gateway Datasource ID"}),
	Columns2 = Table.SelectColumns(Expanded,{"Gateway ID", "Gateway Datasource ID"}),
	members2 = Table.AddColumn(Columns2, "Gateway Data Source Users", each try Table.FromRecords(Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/gateways/" & Text.From([Gateway ID])&"/datasources/" & Text.From([Gateway Datasource ID])& "/users"))[value] ) otherwise null ),
	Expanded2 = Table.ExpandTableColumn(members2, "Gateway Data Source Users", {"emailAddress", "datasourceAccessRight", "displayName", "identifier", "principalType"}, {"Data Source User Email Address", "Data Source Permission Level", "Data Source User Name", "Data Source User Identifier", "Data Source User Type"}),
        filterNoDataSource = Table.SelectRows(Expanded2, each ([Gateway Datasource ID] <> null)),
	ChangeType = Table.TransformColumnTypes(filterNoDataSource,{{"Data Source User Type", type text}, {"Data Source User Identifier", type text}, {"Data Source User Name", type text}, {"Data Source Permission Level", type text}, {"Data Source User Email Address", type text}, {"Gateway Datasource ID", type text}, {"Gateway ID", type text}})
in
	ChangeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupsAsAdmin = () =>
let 
	BaseUrl         = "https://api.powerbi.com/v1.0/myorg/admin/Groups?$expand=reports,users,datasets,dataflows,dashboards",
	EntitiesPerPage = 5000,
 
	GetJson = (Url) =>
        	let RawData = Web.Contents(Url),
			Json    = Json.Document(RawData)
		in  
			Json,
 
	GetEntityCount = () =>
		let Url   = BaseUrl & "&$top=1",
			Json  = GetJson(Url),
			Count = Json[#"@odata.count"]
        	in  
			Count,
 
	GetPage = (Index) =>
		let Skip  = "$skip=" & Text.From(Index * EntitiesPerPage),
			Top   = "$top=" & Text.From(EntitiesPerPage),
			Url   = BaseUrl & "&" & Skip & "&" & Top,
			Json  = GetJson(Url),
			Value = Json[#"value"]
		in  
			Value,
 
	EntityCount = List.Max({ EntitiesPerPage, GetEntityCount() }),
	PageCount   = Number.RoundUp(EntityCount / EntitiesPerPage),
	PageIndices = { 0 .. PageCount - 1 },
	Pages       = List.Transform(PageIndices, each GetPage(_)),
	Entities    = List.Union(Pages),
	Table       = Table.FromList(Entities, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	expandColumns = Table.ExpandRecordColumn(Table, "Column1", {"id", "name", "isReadOnly", "isOnDedicatedCapacity", "capacityMigrationStatus", "capacityId", "description", "type", "state", "upstreamDataflowsOfDatasets", "reports", "users", "datasets", "dataflows", "dashboards"}, {"Workspace ID", "Workspace Name", "Is Read Only", "Is On Dedicated Capacity", "Capacity Migration Status", "capacityId", "Workspace Description", "Workspace Type", "Workspace State", "upstreamDataflowsOfDatasets", "reports", "users", "datasets", "dataflows", "dashboards"}),
	changeType = Table.TransformColumnTypes(expandColumns,{{"Is Read Only", type logical}, {"Is On Dedicated Capacity", type logical}, {"Workspace ID", type text}, {"Workspace Name", type text}, {"Capacity Migration Status", type text}, {"capacityId", type text}, {"Workspace Description", type text}, {"Workspace Type", type text}, {"Workspace State", type text}})
in
    	changeType;


[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.GroupUsersAsAdmin = () =>
let
	source = PowerBIRESTAPI.GroupsAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Workspace ID", "Workspace Type", "Workspace State", "users"}),
	convertToRecords = Table.ExpandListColumn(trimColumns, "users"),
	expandRecords = Table.ExpandRecordColumn(convertToRecords, "users", {"emailAddress", "groupUserAccessRight", "identifier", "principalType", "displayName"}, {"Email Address", "User Access Rights", "User Identifier", "User Principal Type", "Workspace User Display Name"}),
	changeType = Table.TransformColumnTypes(expandRecords,{{"Email Address", type text}, {"User Access Rights", type text}, {"User Identifier", type text}, {"User Principal Type", type text}, {"Workspace User Display Name", type text}})
in
	changeType;


[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.ReportsAsAdmin = () =>
let
	source = PowerBIRESTAPI.GroupsAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Workspace ID", "reports"}),
	convertToRecords = Table.ExpandListColumn(trimColumns, "reports"),
	expandRecords = Table.ExpandRecordColumn(convertToRecords, "reports", {"id", "reportType", "name", "datasetId"}, {"Report ID", "Report Type", "Report Name", "Dataset ID"}),
	filterNoReports = Table.SelectRows(expandRecords, each ([Report ID] <> null)),
	changeType = Table.TransformColumnTypes(filterNoReports,{{"Report ID", type text}, {"Report Type", type text}, {"Report Name", type text}, {"Dataset ID", type text}})
in
	changeType;


[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.DashboardsAsAdmin = () =>
let
	source = PowerBIRESTAPI.GroupsAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Workspace ID", "dashboards"}),
	convertToRecords = Table.ExpandListColumn(trimColumns, "dashboards"),
	expandRecords = Table.ExpandRecordColumn(convertToRecords, "dashboards", {"id", "displayName", "isReadOnly"}, {"Dashboard ID", "Dashboard Name", "Is Read Only"}),
	filterNoDashboards = Table.SelectRows(expandRecords, each ([Dashboard ID] <> null)),
	changeType = Table.TransformColumnTypes(filterNoDashboards,{{"Dashboard ID", type text}, {"Dashboard Name", type text}, {"Is Read Only", type logical}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.DatasetsAsAdmin = () =>
let
	source = PowerBIRESTAPI.GroupsAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Workspace ID", "datasets"}),
	convertToRecords = Table.ExpandListColumn(trimColumns, "datasets"),
	expandRecords = Table.ExpandRecordColumn(convertToRecords, "datasets", {"id", "name", "addRowsAPIEnabled", "configuredBy", "isRefreshable", "isEffectiveIdentityRequired", "isEffectiveIdentityRolesRequired", "isOnPremGatewayRequired", "targetStorageMode"}, {"Dataset ID", "Dataset Name", "Is Add Rows API Enabled", "Dataset Configured By", "Is Refreshable", "Is Effective Identity Required", "Is Effective Identity Roles Required", "Is On Prem Gateway Required", "Target Storage Mode"}),
	filterNoDatasets = Table.SelectRows(expandRecords, each ([Dataset ID] <> null)),
	changeType = Table.TransformColumnTypes(filterNoDatasets,{{"Dataset ID", type text}, {"Dataset Name", type text}, {"Is Add Rows API Enabled", type logical}, {"Dataset Configured By", type text}, {"Is Refreshable", type logical}, {"Is Effective Identity Required", type logical}, {"Is Effective Identity Roles Required", type logical}, {"Is On Prem Gateway Required", type logical}, {"Target Storage Mode", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.DataflowsAsAdmin = () =>
let
	source = PowerBIRESTAPI.GroupsAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Workspace ID", "dataflows"}),
	convertToRecords = Table.ExpandListColumn(trimColumns, "dataflows"),
	expandRecords = Table.ExpandRecordColumn(convertToRecords, "dataflows", {"objectId", "name", "description", "configuredBy"}, {"Dataflow ID", "Dataflow Name", "Dataflow Description", "Dataflow Configured By"}),
	filterNoDataflows = Table.SelectRows(expandRecords, each ([Dataflow ID] <> null)),
	changeType = Table.TransformColumnTypes(filterNoDataflows,{{"Dataflow ID", type text}, {"Dataflow Name", type text}, {"Dataflow Description", type text}, {"Dataflow Configured By", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.CapacitiesAsAdmin = () =>
let
	source = Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/admin/capacities"))[value],
	convertToTable = Table.FromList(source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	expandRecords = Table.ExpandRecordColumn(convertToTable, "Column1", {"id", "displayName", "sku", "state", "region"}, {"Capacity ID", "Capacity Name", "Capacity SKU", "Capacity State", "Capacity Region"}),
	changeType = Table.TransformColumnTypes(expandRecords,{{"Capacity ID", type text}, {"Capacity Name", type text}, {"Capacity SKU", type text}, {"Capacity State", type text}, {"Capacity Region", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.CapacityRefreshablesAsAdmin = () =>
let
	source = PowerBIRESTAPI.CapacitiesAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Capacity ID"}),
    apiCall = Table.AddColumn(trimColumns, "Capacity Refreshables", each try Table.FromRecords(Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/admin/capacities/" & Text.From([Capacity ID])&"/refreshables?$expand=group"))[value],{"id", "name", "kind", "lastRefresh", "refreshSchedule", "configuredBy", "group"},MissingField.UseNull) otherwise null ),
    expandCapacityRefreshables = Table.ExpandTableColumn(apiCall, "Capacity Refreshables", {"id", "name", "kind", "lastRefresh", "refreshSchedule", "configuredBy", "group"}, {"Capacity Refreshable ID", "Capacity Refreshable Name", "Capacity Refreshable Kind", "lastRefresh", "refreshSchedule", "configuredBy", "group"}),
    filterNoRefreshables = Table.SelectRows(expandCapacityRefreshables, each ([Capacity Refreshable ID] <> null)),
    expandRefreshSchedule = Table.ExpandRecordColumn(filterNoRefreshables, "refreshSchedule", {"days", "times", "enabled", "localTimeZoneId", "notifyOption"}, {"Refresh Schedule Days", "Refresh Schedule Times", "Refresh Enabled", "Time Zone", "Notify Option"}),
    extractedDays = Table.TransformColumns(expandRefreshSchedule, {"Refresh Schedule Days", each Text.Combine(List.Transform(_, Text.From), ","), type text}),
    replaceEveryday = Table.ReplaceValue(extractedDays,"Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday","Everyday",Replacer.ReplaceText,{"Refresh Schedule Days"}),
    replacedWeekday = Table.ReplaceValue(replaceEveryday,"Monday,Tuesday,Wednesday,Thursday,Friday","Every Weekday",Replacer.ReplaceText,{"Refresh Schedule Days"}),
    extractedTimes = Table.TransformColumns(replacedWeekday, {"Refresh Schedule Times", each Text.Combine(List.Transform(_, Text.From), ","), type text}),
    expandConfiguredBy = Table.ExpandListColumn(extractedTimes, "configuredBy"),
    expandGroup = Table.ExpandRecordColumn(expandConfiguredBy, "group", {"id"}, {"Workspace ID"}),
    expandLastRefresh = Table.ExpandRecordColumn(expandGroup, "lastRefresh", {"id", "refreshType", "startTime", "endTime", "serviceExceptionJson", "status", "requestId"}, {"Last Refresh ID", "Last Refresh Type", "Last Refresh Start Time", "Last Refresh End Time", "serviceExceptionJson", "Last Refresh Status", "Last Refresh Request ID"}),
    #"Parsed JSON" = Table.TransformColumns(expandLastRefresh,{{"serviceExceptionJson", Json.Document}}),
    #"Replaced Errors" = Table.ReplaceErrorValues(#"Parsed JSON", {{"serviceExceptionJson", null}}),
    #"Expanded serviceExceptionJson" = Table.ExpandRecordColumn(#"Replaced Errors", "serviceExceptionJson", {"error"}, {"error"}),
    #"Expanded error" = Table.ExpandRecordColumn(#"Expanded serviceExceptionJson", "error", {"code", "pbi.error"}, {"Last Refresh Error Code", "pbi.error"}),
    #"Expanded pbi.error" = Table.ExpandRecordColumn(#"Expanded error", "pbi.error", {"details"}, {"details"}),
    #"Expanded details2" = Table.ExpandListColumn(#"Expanded pbi.error", "details"),
    #"Expanded details1" = Table.ExpandRecordColumn(#"Expanded details2", "details", {"code", "detail"}, {"Last Refresh Error Label", "detail"}),
    #"Filtered Rows" = Table.SelectRows(#"Expanded details1", each ([Last Refresh Error Label] <> "ActivityIdText" and [Last Refresh Error Label] <> "ClusterUriText" and [Last Refresh Error Label] <> "RequestIdText" and [Last Refresh Error Label] <> "TimestampText")),
    #"Expanded detail" = Table.ExpandRecordColumn(#"Filtered Rows", "detail", {"value"}, {"Last Refresh Error Value"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded detail",{{"Capacity Refreshable ID", type text}, {"Capacity Refreshable Name", type text}, {"Capacity Refreshable Kind", type text}, {"Last Refresh Type", type text}, {"Last Refresh Status", type text}, {"Last Refresh Request ID", type text}, {"Refresh Schedule Days", type text}, {"Refresh Schedule Times", type text}, {"Time Zone", type text}, {"Notify Option", type text}, {"configuredBy", type text}, {"Workspace ID", type text}, {"Last Refresh ID", Int64.Type}, {"Last Refresh Start Time", type datetimezone}, {"Last Refresh End Time", type datetimezone}, {"Last Refresh Error Code", type text}, {"Last Refresh Error Label", type text}, {"Last Refresh Error Value", type text}, {"Refresh Enabled", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","false","No",Replacer.ReplaceText,{"Refresh Enabled"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","true","Yes",Replacer.ReplaceText,{"Refresh Enabled"})
in
    #"Replaced Value1";

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.DatasetDatasourcesAsAdmin = () =>
let
	source = PowerBIRESTAPI.DatasetsAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Dataset ID"}),
	datasources = Table.AddColumn(trimColumns, "datasources", each try Table.FromRecords(Json.Document(Web.Contents( "https://api.powerbi.com/v1.0/myorg/admin/datasets/" & Text.From([Dataset ID])&"/datasources") )[value],{"datasourceType", "connectionDetails", "datasourceId", "gatewayId"},MissingField.UseNull) otherwise null ),
	expandDatasources = Table.ExpandTableColumn(datasources, "datasources", {"datasourceType", "connectionDetails", "datasourceId", "gatewayId"}, {"Datasource Type", "connectionDetails", "Datasource ID", "Gateway ID"}),
	filterNoRefreshables = Table.SelectRows(expandDatasources, each ([Datasource ID] <> null)),
	expandConnectionDetails = Table.ExpandRecordColumn(filterNoRefreshables, "connectionDetails", {"path", "kind", "connectionString", "extensionDataSourceKind", "extensionDataSourcePath", "account", "domain", "server", "database", "sharePointSiteUrl", "url"}, {"path", "kind", "connectionString", "extensionDataSourceKind", "extensionDataSourcePath", "account", "domain", "server", "database", "sharePointSiteUrl", "url"}),
	ServerAndDB = Table.AddColumn(expandConnectionDetails,"Server And Database", each [server]&" | "&[database]),
	ExtensionFull = Table.AddColumn(ServerAndDB, "ExtensionFull", each [kind] & " | " & [path]),
	ConnectionInfo = Table.AddColumn(ExtensionFull, "Connection Information", each if [Datasource Type] = "AnalysisServices" then [Server And Database] 
        else if [Datasource Type] = "ODBC" then [connectionString] else if [Datasource Type] = "Sql" then [Server And Database] 
        else if [Datasource Type] = "File" then [path] 
        else if [Datasource Type] = "ActiveDirectory" then [domain] 
        else if [Datasource Type] = "Folder" then [path] 
        else if [Datasource Type] = "Web" then [url] 
        else if [Datasource Type] = "MySql" then [Server And Database] 
        else if [Datasource Type] = "DB2" then [Server And Database] 
        else if [Datasource Type] = "OData" then [url] 
        else if [Datasource Type] = "SharePointList" then [url] 
        else if [Datasource Type] = "Extension" then [ExtensionFull]  
        else if [Datasource Type] = "Teradata" then [server] 
        else if [Datasource Type] = "Oracle" then [server] 
        else if [Datasource Type] = "Exchange" then [emailAddress] 
        else if [Datasource Type] = "OleDb" then [connectionString] 
        else if [Datasource Type] = "AzureBlobs" then [account]&" | "&[domain] 
        else "Requires Mapping"),
	removeColumns = Table.SelectColumns(ConnectionInfo,{"Dataset ID", "Datasource ID", "Gateway ID", "Connection Information", "Datasource Type"}),
	changeType = Table.TransformColumnTypes(removeColumns,{{"Datasource ID", type text}, {"Gateway ID", type text}, {"Connection Information", type text}, {"Datasource Type", type text}})
in
	changeType;

[DataSource.Kind="PowerBIRESTAPI"]
	PowerBIRESTAPI.DataflowDatasourcesAsAdmin = () =>
let
	source = PowerBIRESTAPI.DataflowsAsAdmin(),
	trimColumns = Table.SelectColumns(source,{"Dataflow ID"}),
    datasources = Table.AddColumn(trimColumns, "datasources", each try Table.FromRecords(Json.Document(Web.Contents("https://api.powerbi.com/v1.0/myorg/admin/dataflows/" & Text.From([Dataflow ID])&"/datasources"))[value],{"datasourceType", "connectionDetails", "datasourceId", "gatewayId"},MissingField.UseNull) otherwise null ),
	expandDatasources = Table.ExpandTableColumn(datasources, "datasources", {"datasourceType", "connectionDetails", "datasourceId", "gatewayId"}, {"Datasource Type", "connectionDetails", "Datasource ID", "Gateway ID"}),
	filterNoRefreshables = Table.SelectRows(expandDatasources, each ([Datasource ID] <> null)),
    expandConnectionDetails = Table.ExpandRecordColumn(filterNoRefreshables, "connectionDetails", {"path", "connectionString", "extensionDataSourceKind", "extensionDataSourcePath", "account", "domain", "server", "database", "sharePointSiteUrl", "url"}, {"path", "connectionString", "extensionDataSourceKind", "extensionDataSourcePath", "account", "domain", "server", "database", "sharePointSiteUrl", "url"}),
	ServerAndDB = Table.AddColumn(expandConnectionDetails,"Server And Database", each [server]&" | "&[database]),
	ExtensionFull = Table.AddColumn(ServerAndDB, "ExtensionFull", each [extensionDataSourceKind] & " | " & [extensionDataSourcePath]),
	ConnectionInfo = Table.AddColumn(ExtensionFull, "Connection Information", each if [Datasource Type] = "AnalysisServices" then [Server And Database] 
		else if [Datasource Type] = "ODBC" then [connectionString] 
		else if [Datasource Type] = "Sql" then [Server And Database] 
		else if [Datasource Type] = "File" then [path] 
		else if [Datasource Type] = "ActiveDirectory" then [domain] 
		else if [Datasource Type] = "Folder" then [path] 
		else if [Datasource Type] = "Web" then [url] 
		else if [Datasource Type] = "MySql" then [Server And Database] 
		else if [Datasource Type] = "DB2" then [Server And Database] 
		else if [Datasource Type] = "OData" then [url] 
		else if [Datasource Type] = "SharePointList" then [sharePointSiteUrl] 
		else if [Datasource Type] = "Extension" then [ExtensionFull]  
		else if [Datasource Type] = "Teradata" then [server] 
		else if [Datasource Type] = "Oracle" then [server] 
		else if [Datasource Type] = "Exchange" then [emailAddress] 
		else if [Datasource Type] = "OleDb" then [connectionString] 
		else if [Datasource Type] = "AzureBlobs" then [account]&" | "&[domain] 
		else "Requires Mapping"),
	removeColumns = Table.SelectColumns(ConnectionInfo,{"Dataflow ID", "Datasource ID", "Gateway ID", "Connection Information", "Datasource Type"}),
	changeType = Table.TransformColumnTypes(removeColumns,{{"Datasource ID", type text}, {"Gateway ID", type text}, {"Connection Information", type text}, {"Datasource Type", type text}})
in
	changeType;

//
// Data Source definition
//
PowerBIRESTAPI = [
TestConnection = (dataSourcePath) =>  { "PowerBIRESTAPI.Navigation"},
    Authentication = [
       Aad =  [AuthorizationUri = authorize_uri,
            Resource = resourceUri]            
    ],
    Label = Extension.LoadString("DataSourceLabel") 
];

//
// UI Export definition
//
PowerBIRESTAPI.UI = [
    Beta = true,
    Category = "Power Platform",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    SourceImage = PBIAPI.Icons ,
    SourceTypeImage = PBIAPI.Icons 
];

PBIAPI.Icons = [
    Icon16 = { Extension.Contents("PBIAPI16.png"), Extension.Contents("PBIAPI20.png"), Extension.Contents("PBIAPI24.png"), Extension.Contents("PBIAPI32.png") },
    Icon32 = { Extension.Contents("PBIAPI32.png"), Extension.Contents("PBIAPI40.png"), Extension.Contents("PBIAPI48.png"), Extension.Contents("PBIAPI64.png") }
];



Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta 
        [
            NavigationTable.NameColumn = nameColumn, 
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn, 
            Preview.DelayColumn = itemNameColumn, 
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;

Table.ForceToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta 
        [
            NavigationTable.NameColumn = nameColumn, 
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn, 
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;

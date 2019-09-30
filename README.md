# PowerBIRESTAPI
Big thank you to https://github.com/klinejordan for contributing to this repo! 

A Microsoft Power BI Data Connector or Power Query Connector for the Power BI REST API.

The goal of this connector is to enable you as an end-user to easily:
- Create a catalogue of all the resources deployed to your tenant
    - Dashboards
    - Reports
    - Datasets
- Retrieve a list of the members and types of access for each member inside an app workspace 'aka' Group
- Analyze Refresh history and error codes
![Power BI REST API Connector](https://image.ibb.co/jOcHyQ/image.png)

# Power BI REST API Documentation
Be sure to read the official documentation from Microsoft about the Power BI REST API on:
https://msdn.microsoft.com/library/dn877544.aspx

# Step 1: Register your App
The first step would be to register your very own Native Client App. You can read the full documentation on:
https://powerbi.microsoft.com/en-us/documentation/powerbi-developer-register-app/

or just click here to create it right away:
https://dev.powerbi.com/apps

You'll need to fill out the form in that page and please use the following values:
- App Type = Native Client
- Name of your App = 'Can be any text string'

For the rest of fields, please use the options chosen in the next image: 
![Register an App form](https://i.ibb.co/Trn7XTz/1-Register.png)

After filling out the fields, go ahead and click the 'Register App' button and right beneath that button you'll get your Application ID. Be sure to save that value as you'll need it later.
![Copy ApplicationID](https://i.ibb.co/jGnkq8G/2-Copy-App-Id.png)

# Step 2:
Retrieve the Client Secret from Azure Portal and add the redirect URL. 
You can use this link: https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade 
Then follow the steps outlined below:

Select the API:

![Select API in Azure Portal]( https://i.ibb.co/VDj9Fs1/3-Adjust-In-Azure-Portal.png)

Navigate to "Certificates & secrets" and click "New client secret":

![Certificates & secrets]( https://i.ibb.co/CMss69q/4-Create-New-Clien-Secret.png)

Copy the secret and save it, as it will be used later:

![Copy client secret]( https://i.ibb.co/94N9YCx/5-Copy-Client-Secret.png)

Navigate to "Overview" and select "Redirect URIs":

![Overview]( https://i.ibb.co/bgjLXFn/6-Add-Redirect-URL.png)

Create new "Web"-type and enter https://oauth.powerbi.com/views/oauthredirect.html  :

![Add Redirect URI]( https://i.ibb.co/NT31Cb7/7-Redirect-URL2.png)

# Step 3: Change the contents of the AppID.txt
1. Download the pre-compiled *.mez* file here https://github.com/migueesc123/PowerBIRESTAPI/blob/master/Power%20BI%20API.mez
2. Rename the extension of the downloaded file from *.mez* to *.zip*
3. Unzip the file in a new folder
4. Open the file with the name AppID.txt and replace the value found inside with the Application ID that you received before and save the file.
5. Open the file with the name ClientSecret.txt and replace the value found inside with the Client Secret that you received before and save the file.
5. Select all the files inside the unzipped folder and zip it again, but now change the extension from *.zip* to *.mez*
6. Place the file inside this folder C:\Users\{Username}\Documents\Microsoft Power BI Desktop\Custom Connectors
    *Note: if the folder doesn't exist, go ahead and create it. Don't forget to enable the Custom Data Connectors preview feature in your Power BI Desktop*
7. Open Power BI Desktop and, in the Get Data window, search for the new Custom Connector.

# Step 4: Provide Feedback!
Let me know your thoughts! go to the issues section of this repo and let me know if you have any issues or suggestions for this connector.

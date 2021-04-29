# PowerBIRESTAPI
Big thank you to https://github.com/klinejordan for contributing to this repo! 

A Microsoft Power BI Data Connector or Power Query Connector for the Power BI REST API.

The goal of this connector is to enable you as an end-user or a tenant admin to easily:
- Create a catalogue of all the resources deployed to your tenant
    - Dashboards
    - Reports
    - Datasets
    - Dataflows
    - Gateways
- Retrieve a list of the members and types of access for each member inside an app workspace 'aka' Group
- Analyze Refresh history and error codes
![Power BI REST API Connector](https://i.ibb.co/m8tBdtM/PBIRESTAPI.png)

Some API end points perform poorly on large tenants, and as such we have included those in an "Experimental" folder as we cannot guarantee performance of these queries. 

# Power BI REST API Documentation
Be sure to read the official documentation from Microsoft about the Power BI REST API on:
https://msdn.microsoft.com/library/dn877544.aspx

# To use the custom connector
You can grab the .mez file from this [link](https://github.com/migueesc123/PowerBIRESTAPI/raw/master/Power%20BI%20API.mez) and place it in your Power BI custom connectors folder. No other setup is required. You should be able to see the Power BI API Custom Connector in your Get Data Window:

![Power BI API Custom Connector in Get Data window](https://github.com/migueesc123/PowerBIRESTAPI/blob/master/Power%20BI%20REST%20API.png)

For more information on how to create your own custom connectors folder, please visit the [official documentation from Microsoft Power BI Custom Connectors](https://docs.microsoft.com/en-us/power-bi/connect-data/desktop-connector-extensibility#custom-connectors).

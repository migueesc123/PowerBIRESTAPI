// Use this file to write queries to test your data connector
let
    x= PowerBIRESTAPI.Navigation(){[Name="Functions"]}[Data],
    y = x{[Name="GETRawData"]}[Data],
    z = y("/gateways/17df3bdf-6370-4ebc-918a-b443cf282c07/datasources/d0d0046f-dac5-4efd-8fb3-dae4522da4af/status")
in
    z
// Use this file to write queries to test your data connector
let
    x= PowerBIRESTAPI.Navigation(){[Name="Power BI Service Administrator"]}[Data],
    y = x{[Name="Capacity Refreshables (Admin)"]}[Data]
in
    y
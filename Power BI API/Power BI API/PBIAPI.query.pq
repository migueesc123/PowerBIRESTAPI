// Use this file to write queries to test your data connector
let
    x= PowerBIRESTAPI.Navigation(){[Name="Workspaces"]}[Data],
    y = x{[Name="Upstream Dataflows"]}[Data]
in
    y
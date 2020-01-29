// Use this file to write queries to test your data connector
let
    x= PowerBIRESTAPI.EventActivityLog (#date(2019, 12, 27), #date(2019, 12, 31))
    in
        x
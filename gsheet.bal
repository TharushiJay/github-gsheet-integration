import ballerinax/googleapis.sheets as sheets;
import ballerina/io;

configurable string refreshToken = "1//04xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
configurable string clientId = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com";
configurable string clientSecret = "GOCSPX-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

sheets:ConnectionConfig spreadsheetConfig = {
    auth: {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshUrl: sheets:REFRESH_URL,
        refreshToken: refreshToken
    }
};

sheets:Client spreadsheetClient = check new (spreadsheetConfig);

public function insertIssueDetails(json|error numberParam, json|error actionParam, json|error urlParam,
                            json|error titleParam, json|error timeParam, json|error userParam) returns error? {
    string spreadsheetId = "1l4KUKQ0e5HKB35doSRcaF3QgNYvBAp99q_l5GS3J1B8";
    string sheetName = "Issue";
    string number = (numberParam is json)? numberParam.toString(): "";
    string action = (actionParam is json)? actionParam.toString(): "";
    string url = (urlParam is json)? urlParam.toString(): "";
    string title = (titleParam is json)? titleParam.toString(): "";
    string time = (timeParam is json)? timeParam.toString(): "";
    string user = (userParam is json)? userParam.toString(): "";

    io:println("Issue content: ", number, action, url, title, time, user);
    error? append = check spreadsheetClient->appendRowToSheet(spreadsheetId, sheetName, 
                                                    [number, action, url, title, time, user]);
}

public function insertPRDetails(json|error numberParam, json|error actionParam, json|error urlParam,
                            json|error titleParam, json|error timeParam, json|error userParam) returns error? {
    string spreadsheetId = "1l4KUKQ0e5HKB35doSRcaF3QgNYvBAp99q_l5GS3J1B8";
    string sheetName = "PR";
    string number = (numberParam is json)? numberParam.toString(): "";
    string action = (actionParam is json)? actionParam.toString(): "";
    string url = (urlParam is json)? urlParam.toString(): "";
    string title = (titleParam is json)? titleParam.toString(): "";
    string time = (timeParam is json)? timeParam.toString(): "";
    string user = (userParam is json)? userParam.toString(): "";

    io:println("PR content: ", number, action, url, title, time, user);
    error? append = check spreadsheetClient->appendRowToSheet(spreadsheetId, sheetName, 
                                                    [number, action, url, title, time, user]);
}

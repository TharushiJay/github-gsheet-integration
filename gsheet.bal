
import ballerinax/googleapis.sheets as sheets;

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

public type Details record {
    int number;
    string action;
    string url;
    string title;
    string time;
    string user;
    string sheet?;
};

sheets:Client spreadsheetClient = check new (spreadsheetConfig);
string spreadsheetId = "1l4KUKQ0e5HKB35doSRcaF3QgNYvBAp99q_l5GS3J1B8";

public function insertDetails(Details details) returns error? {
    error? append = check spreadsheetClient->appendRowToSheet(spreadsheetId, details.sheet.toString(), 
                                                    [details.number, details.action, details.url, details.title, details.time, details.user]);

}
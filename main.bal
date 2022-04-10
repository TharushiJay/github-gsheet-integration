import ballerina/websub;
import ballerina/io;

@websub:SubscriberServiceConfig {
    target: [
        "https://api.github.com/hub", 
        "https://github.com/TharushiJay/helloworld/events/*.json" // Set the path to your Github repository
    ],
    callback: "https://b3e0–112–134–171–11.ngrok.io", // Set the ngrok callback URL 
    httpConfig: {
        auth: {
            token: "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" // Set your GitHub Personal Access Token (PAT)
        }
    }
}
service /events on new websub:Listener(9090) {
    remote function onEventNotification(websub:ContentDistributionMessage event) 
                        returns error? {
        var retrievedContent = event.content;
        if (retrievedContent is json) {
            if (retrievedContent.action is string){
                if (retrievedContent.issue is json) {
                    // If the event is related to an Issue
                    error? issueResponse = insertIssueDetails(retrievedContent.issue.number, 
                                                    retrievedContent.action,
                                                    retrievedContent.issue.url,
                                                    retrievedContent.issue.title,
                                                    retrievedContent.issue.updated_at,
                                                    retrievedContent.sender.login);
                }
                else if (retrievedContent.pull_request is json) {
                    // If the event is related to a Pull Request
                    error? pullRequestResponse = insertPRDetails(retrievedContent.number, 
                                                    retrievedContent.action,
                                                    retrievedContent.pull_request.url,
                                                    retrievedContent.pull_request.title,
                                                    retrievedContent.pull_request.updated_at,
                                                    retrievedContent.pull_request.user.login);
                }
            }
        } else {
            io:println("Unrecognized content type");
        }
    }
}

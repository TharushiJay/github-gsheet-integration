import ballerina/websub;
import ballerina/io;

@websub:SubscriberServiceConfig {
    target: [
        "https://api.github.com/hub", 
        "https://github.com/TharushiJay/helloworld/events/*.json" // Set the path to your Github repository
    ],
    callback: "https://6671-2402-d000-811c-7b4a-18dd-31bd-21f7-f9b2.ngrok.io", // Set the ngrok callback URL 
    httpConfig: {
        auth: {
            token: "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" // Set your GitHub Personal Access Token (PAT)
        }
    }
}
service /events on new websub:Listener(9090) {
    remote function onEventNotification(websub:ContentDistributionMessage event) returns error? {

        var retrievedContent = event.content;

        if (retrievedContent is json) {
            if (retrievedContent.action is string){

                Details details = { number: check retrievedContent.issue.number,
                                    action: check retrievedContent.action,
                                    url: check retrievedContent.issue.url,
                                    title: check retrievedContent.issue.title,
                                    time: check retrievedContent.issue.updated_at,
                                    user: check retrievedContent.sender.login };

                if (retrievedContent.issue is json) {

                    // If the event is related to an Issue
                    details.sheet = "Issue";
                    error? response = insertDetails(details);

                } else if (retrievedContent.pull_request is json) {
                    
                    // If the event is related to a Pull Request
                    details.sheet = "PR";
                    error? response = insertDetails(details);
                }
            }
        } else {
            io:println("Unrecognized content type");
        }
    }
}

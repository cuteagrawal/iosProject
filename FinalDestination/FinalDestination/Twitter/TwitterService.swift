import Foundation
import OAuthSwift

// package: https://github.com/OAuthSwift/OAuthSwift.git

/*
 * This class works with X API (Twitter)
 * I am using a package to get authentication from Twitter. New API does not allow
 * direct data to be sent without authentication
 */

class TwitterService {
    
    // Creates only one version of the class
    static let shared = TwitterService()
    
    // This is the URL where the API sends the data
    let baseURL = "https://api.twitter.com/2/tweets"
    
    private init() {}
    
    // This generate the tweet usig API Key, secret key, access token and secret token
    func generateTweet(for tweet: String, completion: @escaping (Bool) -> Void) {
        let apiKey = "cmydQISfwxrppKdrBRApmeRNL"
        let apiSecretKey = "OOfxhKTmRHDTyPea9iQEnLauVpUccrnwsSN7MT8lp1qCWx2fwo"
        let accessToken = "2989656215-oYmiEgiK6pBjc4VPExra0GKgVmk2YgAlS94Brrx"
        let accessSecretToken = "w5WlquHrLNclLzkNlvJ1kS3joWfmVrL15k8H5kL09vIXO"
        
        // using authentication token
        let oauthClient = OAuthSwiftClient(consumerKey: apiKey, consumerSecret: apiSecretKey, oauthToken: accessToken, oauthTokenSecret: accessSecretToken, version: .oauth1)
        
        /*
         reference JSONSerialization swift: https://www.youtube.com/watch?v=Yix4RyEgCdM
         options: .allowFragments allows strings numbers etc. But by deaful it is false and we can use array
         tweet gets data from our users
         */
        
        let parameters = ["text": tweet]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error: Failed to JSONserialize tweet data")
            completion(false)
            return
        }
        
        // post request with jsonised data (tweet)
        oauthClient.post(
            baseURL,
            parameters: parameters,
            headers: ["Content-Type": "application/json"],
            body: jsonData
        ) { result in
            switch result {
            case .success(let response):
                print("Response: \(response)")
                completion(true)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}


// Used POSTMAN to check the API

/*
 information from POSTMAN
 
 curl --location 'https://api.twitter.com/2/tweets' \
 --header 'Content-Type: application/json' \
 --header 'Authorization: OAuth oauth_consumer_key="cmydQISfwxrppKdrBRApmeRNL",oauth_token="2989656215-oYmiEgiK6pBjc4VPExra0GKgVmk2YgAlS94Brrx",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1711933685",oauth_nonce="sUxt8VgU905",oauth_version="1.0",oauth_signature="8BY3yRVNsvQEomk8G0Ory5gCgn0%3D"' \
 --header 'Cookie: guest_id=v1%3A171192776017421354' \
 --data '{
     "text": "Testing Twitter Project"
 }'
 */

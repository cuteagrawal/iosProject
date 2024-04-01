import Foundation
import OAuthSwift

class TwitterService {
    
    static let shared = TwitterService()
    
    let baseURL = "https://api.twitter.com/2/tweets"
    
    private init() {}
    
    func generateTweet(for tweet: String, completion: @escaping (Bool) -> Void) {
        let apiKey = "cmydQISfwxrppKdrBRApmeRNL"
        let apiSecretKey = "OOfxhKTmRHDTyPea9iQEnLauVpUccrnwsSN7MT8lp1qCWx2fwo"
        let accessToken = "2989656215-oYmiEgiK6pBjc4VPExra0GKgVmk2YgAlS94Brrx"
        let accessSecretToken = "w5WlquHrLNclLzkNlvJ1kS3joWfmVrL15k8H5kL09vIXO"
        
        let oauthClient = OAuthSwiftClient(consumerKey: apiKey, consumerSecret: apiSecretKey, oauthToken: accessToken, oauthTokenSecret: accessSecretToken, version: .oauth1)
        
        let parameters = ["text": tweet]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error: Failed to serialize tweet data")
            completion(false)
            return
        }
        
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

//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Jack Vial on 11/28/15.
//  Copyright © 2015 Jack Vial. All rights reserved.
//

import Foundation

class NetworkOperation {
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL){
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion){
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request){
            
            // Trailing closure
            (let data, let response, let error) in
            
            // Check response status
            if let httpResponse = response as? NSHTTPURLResponse {
                switch(httpResponse.statusCode){
                case 200:
                    do {
                        // Create json object with data
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                        completion(jsonDictionary)
                    } catch {
                        print("JSON Serialization failed. Error: \(error)")
                    }
                default:
                    print("Get request not successful.  HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error: Not a valid HTTP response")
            }
        }
        dataTask.resume()
    }
}
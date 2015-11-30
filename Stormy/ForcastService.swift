//
//  ForcastService.swift
//  Stormy
//
//  Created by Jack Vial on 11/29/15.
//  Copyright © 2015 Jack Vial. All rights reserved.
//

import Foundation

struct ForecastService {
    let forecastAPIKey: String
    let forecastBaseUrl: NSURL?
    
    init(APIKey: String){
        forecastAPIKey = APIKey
        forecastBaseUrl = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)){
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseUrl){
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSONFromURL {
                
                // Trailing closure. Same as anon callback in JS
                (let JSONDictionary) in
                let currentWeather = self.currentWeatherFromjson(JSONDictionary)
                
                // Pass value to callback
                completion(currentWeather)
            }
        } else {
            print("Count not construct a valid URL")
        }
    }
    
    // Function with one arg of type dictionary
    // returns type CurrentWeather or nil
    func currentWeatherFromjson(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        } else {
            print("JSON dictionary returned nil for 'currently' key")
            return nil
        }
    }
}
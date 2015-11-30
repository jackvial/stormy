//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Jack Vial on 11/27/15.
//  Copyright © 2015 Jack Vial. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> UIImage? {
        var imageName: String
        switch self {
        case .ClearDay:
            imageName = "clear-day.png"
        case .ClearNight:
            imageName = "clear-night.png"
        case .Rain:
            imageName = "rain.png"
        case .Snow:
            imageName = "snow.png"
        case .Sleet:
            imageName = "sleet.png"
        case .Wind:
            imageName = "wind.png"
        case .Fog:
            imageName = "fog.png"
        case .Cloudy:
            imageName = "cloudy.png"
        case .PartlyCloudyDay:
            imageName = "cloudy-day.png"
        case .PartlyCloudyNight:
            imageName = "cloudy-night.png"
        }
        return UIImage(named: imageName)
    }
}

struct CurrentWeather {
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
    // Dictionary where the key is a String
    // and the value can be AnyObject
    init(weatherDictionary: [String: AnyObject]){
        
        // Cast all properties to correct datatype
        temperature = weatherDictionary["temperature"] as? Int
        
        // Get percentage as Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        
        // Get percentage as Int
        if let precipProbabilityFloat = weatherDictionary["precipProbability"] as? Double {
            precipProbability = Int(precipProbabilityFloat * 100)
        } else {
            precipProbability = nil
        }
        summary = weatherDictionary["summary"] as? String
        
        // Set weather icon
        if let iconString = weatherDictionary["icon"] as? String,
            let weatherIcon: Icon = Icon(rawValue: iconString){
            icon = weatherIcon.toImage()
        }
    }
}
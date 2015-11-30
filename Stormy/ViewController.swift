//
//  ViewController.swift
//  Stormy
//
//  Created by Jack Vial on 11/27/15.
//  Copyright © 2015 Jack Vial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummaryLabel: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    private let forecastAPIKey = "9f018cdb49a28c5074d4e5e375ae6309"
    let coordinate: (lat: Double, long: Double) = (41.415602,-81.923473)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchWeatherForecast(){
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long){
            (let currently) in
            if let currentWeather = currently {
                
                // Make sure the code for updating the UI executes on the main thread
                // moves exeution from background to main thread
                dispatch_async(dispatch_get_main_queue()){
                    if let temperature = currentWeather.temperature {
                        
                        // Need to use self inside a closure when refering to
                        // a class property
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let percipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "\(percipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummaryLabel?.text = summary
                    }
                    self.toggleRefreshAnimation(false)
                }
            }
        }
    }
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        fetchWeatherForecast()
    }
    
    func toggleRefreshAnimation(on: Bool){
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
    
}


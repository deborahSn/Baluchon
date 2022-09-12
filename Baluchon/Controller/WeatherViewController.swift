//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Déborah Suon on 20/09/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var iconWeatherDestination: UIImageView!
    @IBOutlet weak var iconWeatherLocalisation: UIImageView!
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet weak var descriptionWeatherDestination: UILabel!
    @IBOutlet weak var descriptionWeatherLocalisation: UILabel!
    @IBOutlet weak var tempDestination: UILabel!
    @IBOutlet weak var tempLocalisation: UILabel!
    
    private let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
    }
    
    @IBAction func tappedButtonWeather(_ sender: Any) {
        updateWeather()
    }
    
    private func updateWeather() {
        weatherService.fetchWeather { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) : self.updateNewyork(dataWeatherInstance: data)
                    self.updateParis(dataWeatherInstance: data)
                case .failure(_): self.presentAlert(with: "error")
                }
            }
        }
    }
    
    private func updateNewyork(dataWeatherInstance: WeatherInfo){
        // DESCRIPTION New York
        descriptionWeatherLocalisation.text = dataWeatherInstance.list[0].weather.first?.description
        //TEMPERATURE New York
        let temperature = String(dataWeatherInstance.list[0].main.temp)
        tempLocalisation.text = temperature + " °C"
    }
    
    private func updateParis(dataWeatherInstance: WeatherInfo){
        // DESCRIPTION Paris
        descriptionWeatherDestination.text = dataWeatherInstance.list[1].weather.first?.description
        //TEMPERATURE Paris
        let temperature =  String(dataWeatherInstance.list[1].main.temp)
        tempDestination.text = temperature + " °C"
    }
    
}

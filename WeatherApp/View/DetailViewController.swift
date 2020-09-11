//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Oleg Gavrilich on 15.08.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    // MARK: - Parameters
    
    var provider: WeatherServiceProvider = OpenWeatherServiceProvider()
    var coordinates : CLLocationCoordinate2D?
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var citySunsetLabel: UILabel!
    @IBOutlet weak var citySunriseLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureFeelsLikeLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegreeLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let coordinates = coordinates else { return }

        activityIndicator.startAnimating()
        provider.getWeather(latitude: coordinates.latitude, longitude: coordinates.longitude) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.cityLabel.text = "\(result.name) (\(result.base.country))"
                    self.citySunsetLabel.text = self.timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(result.base.sunset)))
                    self.citySunriseLabel.text = self.timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(result.base.sunrise)))
                    
                    if let weatherDescription = result.weather.first?.description {
                        self.cityLabel.text = self.cityLabel.text ?? "" + " " + weatherDescription
                    }
                    
                    self.temperatureLabel.text = "\(result.temperature.value) C"
                    self.temperatureFeelsLikeLabel.text = "\(result.temperature.feelsLike) C"
                    
                    self.windSpeedLabel.text = "\(result.wind.speed) m/s"
                    self.windDegreeLabel.text = "\(result.wind.degree)"
                    
                    self.pressureLabel.text = "\(result.temperature.pressure)"
                    self.humidityLabel.text = "\(result.temperature.humidity)"
                    
                    self.contentView.isHidden = false
                } else {
                    
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

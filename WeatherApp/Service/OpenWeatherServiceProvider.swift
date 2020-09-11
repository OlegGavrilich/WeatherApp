//
//  OpenWeatherServiceProvider.swift
//  WeatherApp
//
//  Created by Oleg Gavrilich on 10.08.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

class OpenWeatherServiceProvider: WeatherServiceProvider {
    
    private enum Constants {
        enum Api {
            static let key = "6360083c8369b2d483a7c92329d537f6"
            static let baseURL = "http://api.openweathermap.org/data/2.5"
        }
    }
    
    // MARK: - MoviesServiceProtocol
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResult?, Error?) -> Void) {
        let urlString = Constants.Api.baseURL
            + "/weather?"
            + "lat=\(latitude)&lon=\(longitude)"
            + "&units=metric"
            + "&APPID=\(Constants.Api.key)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherResult.self, from: data)
                completion(weather, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
    }
}

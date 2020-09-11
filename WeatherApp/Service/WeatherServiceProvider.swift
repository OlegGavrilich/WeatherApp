//
//  WeatherServiceProvider.swift
//  WeatherApp
//
//  Created by Oleg Gavrilich on 09.08.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

protocol WeatherServiceProvider {
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResult?, Error?) -> Void)
    
}

//
//  Weather.swift
//  WeatherApp
//
//  Created by Oleg Gavrilich on 10.08.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

class WeatherResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case weather
        case temperature = "main"
        case wind
        case base = "sys"
    }
    
    let name: String
    let weather: [Weather]
    let temperature: Temperature
    let wind: Wind
    let base: LocaltionBase
}

struct Temperature: Codable {
    enum CodingKeys: String, CodingKey {
        case value = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
    
    let value: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
}

struct LocaltionBase: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct Weather: Codable {
    let description: String
}

struct Wind: Codable {
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
    
    let speed: Double
    let degree: Int
}

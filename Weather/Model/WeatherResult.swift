//
//  WeatherResult.swift
//  Weather
//
//  Created by Kelvin Fok on 21/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    
    static var empty: WeatherResult {
        return WeatherResult(main: Weather.init(temp: 0.0, humidity: 0.0))
    }
    
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}

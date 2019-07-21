//
//  URL+Extension.swift
//  Weather
//
//  Created by Kelvin Fok on 21/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=1266f20628258429083a478eac387165&units=imperial")
    }
    
    
}

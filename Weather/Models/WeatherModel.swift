//
//  WeatherModel.swift
//  Weather
//
//  Created by Moody on 2023-06-05.
//

import Foundation

struct WeatherResponse: Codable {
    let list: [Weather]
}

struct Weather: Codable {
    let date: Double
    let main: Main
    let pop: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case pop
    }
}

struct Main: Codable {
    let tempMax: Double
    let tempMin: Double
    
    enum CodingKeys: String, CodingKey {
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}

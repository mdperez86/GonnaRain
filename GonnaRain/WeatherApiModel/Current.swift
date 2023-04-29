//
//  Current.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct Current: Decodable {
    let condition: Condition
    let temp_c: Double
    let feelslike_c: Double
    let wind_kph: Double
    let gust_kph: Double
    let pressure_in: Double
    let humidity: Double
    let precip_mm: Double
    let uv: Double
    
    static let example = Current(condition: Condition.example, temp_c: 20, feelslike_c: 18, wind_kph: 20, gust_kph: 23, pressure_in: 10, humidity: 9, precip_mm: 9, uv: 1)
}

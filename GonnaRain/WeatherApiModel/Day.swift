//
//  Day.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct Day: Decodable {
    let condition: Condition
    let avgtemp_c: Double
    let maxtemp_c: Double
    let mintemp_c: Double
    let maxwind_kph: Double
    let totalprecip_mm: Double
    let totalsnow_cm: Double
    let avghumidity: Double
    let uv: Double
    
    static let example = Day(condition: Condition.example, avgtemp_c: (30 + 18) / 2, maxtemp_c: 30, mintemp_c: 18, maxwind_kph: 13, totalprecip_mm: 0.2, totalsnow_cm: 0, avghumidity: 68, uv: 2)
}

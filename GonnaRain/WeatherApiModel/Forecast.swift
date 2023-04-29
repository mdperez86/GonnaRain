//
//  Forecast.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

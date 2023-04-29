//
//  ForecastResponse.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct ForecastResponse: Decodable {
    let current: Current
    let location: Location
    let forecast: Forecast
}

//
//  Condition.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct Condition: Decodable {
    let icon: String
    let text: String
    var imageUrl: String {
        return "https:\(icon)".replacingOccurrences(of: "64x64", with: "128x128")
    }
    
    static let example = Condition(icon: "//cdn.weatherapi.com/weather/64x64/day/176.png", text: "Patchy rain possible")
}

//
//  Location.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct Location: Decodable {
    let name: String
    
    static let example = Location(name: "Santiago")
}

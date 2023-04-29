//
//  Location.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-28.

import Foundation

enum Env {
    static var host: String {
        return ProcessInfo.processInfo.environment["WEATHER_API"]!
    }

    static var apiKey: String {
        return ProcessInfo.processInfo.environment["WEATHER_API_KEY"]!
    }
}

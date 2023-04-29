//
//  ForecastDay.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct ForecastDay: Decodable, Identifiable {
    var id: Double {
        self.date_epoch
    }
    var localDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        if let date = formatter.date(from: date) {
            return date
        }
        return Date(timeIntervalSince1970: date_epoch)
    }
    let date: String
    let date_epoch: Double
    let day: Day
    let hour: [Hour]
    
    static let example = ForecastDay(date: "2023-04-26", date_epoch: 1682467200, day: Day.example, hour: [Hour.example, Hour.example, Hour.example, Hour.example, Hour.example])
}

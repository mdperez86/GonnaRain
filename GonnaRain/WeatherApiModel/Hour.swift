//
//  Hour.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

struct Hour: Decodable, Identifiable {
    var id: Double {
        self.time_epoch
    }
    var localTime: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone.current
        if let date = formatter.date(from: time) {
            return date
        }
        return Date(timeIntervalSince1970: time_epoch)
    }
    let time: String
    let time_epoch: Double
    let temp_c: Double
    let condition: Condition
    
    static let example = Hour(time: "2023-04-26 00:00", time_epoch: 1682463600, temp_c: 22, condition: Condition.example)
}

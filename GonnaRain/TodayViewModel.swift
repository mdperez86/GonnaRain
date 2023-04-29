//
//  TodayViewModel.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation
import CoreLocation

class TodayViewModel : ObservableObject {
    @Published var locationName: String?
    @Published var current: Current?
    @Published var hours: [Hour]?
    
    @Published var tomorrow: ForecastDay?
    @Published var next7Days: [ForecastDay]?
    
    @Published var loading: Bool = false
    @Published var error: Error?
    
    let host: String?
    let key: String?
    
    init() {
        self.host = Env.host
        self.key = Env.apiKey
    }
    
    func fetch(latitude: Double, longitude: Double) {
        guard let host = host, let key = key, let url = URL(string: "\(host)/v1/forecast.json?key=\(key)&q=\(latitude),\(longitude)&days=8") else {
            return
        }
        
        self.loading = true
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ForecastResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.manageTodayData(response)
                    self?.manageTomorrowData(response.forecast.forecastday)
                    self?.manageNext7DaysData(response.forecast.forecastday)
                    self?.loading = false
                }
            } catch {
                print(#function, error)
                DispatchQueue.main.async {
                    self?.error = error
                    self?.loading = false
                }
            }
        }
        
        task.resume()
    }
    
    private func manageTodayData(_ response: ForecastResponse) -> Void {
        locationName = response.location.name
        current = response.current
        
        let twoDaysHours = response.forecast.forecastday[0...1].flatMap({ day in
            return day.hour
        })
        let filteredHours = twoDaysHours.filter({ hour in
            return Date.now < Date(timeIntervalSince1970: hour.time_epoch)
        })
        hours = filteredHours[0...23].map({ hour in
            return hour
        })
    }
    
    private func manageTomorrowData(_ days: [ForecastDay]) -> Void {
        tomorrow = days[1]
    }
    
    private func manageNext7DaysData(_ days: [ForecastDay]) -> Void {
        next7Days = days[1...days.count - 1].map({ day in
            return day
        })
    }
}

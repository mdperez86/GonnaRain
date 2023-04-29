//
//  Next7DaysViewModel.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 26-04-23.
//

import Foundation

class Next7DaysViewModel : ObservableObject {
    @Published var locationName: String = ""
    @Published var tomorrow: Date? = nil
    @Published var days: [ForecastDay] = []
    
    func fetch(latitude: Double?, longitude: Double?) {
        guard let latitude = latitude, let longitude = longitude, let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=80f086365f6c44498fb202000231404&q=\(latitude),\(longitude)&days=8") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ForecastResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
                    self?.locationName = response.location.name
                    self?.days = response.forecast.forecastday[1...response.forecast.forecastday.count - 1].map({ forecastday in
                        return forecastday
                    })
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

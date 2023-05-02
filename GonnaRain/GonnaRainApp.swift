//
//  WeatherApp.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 25-04-23.
//

import SwiftUI
import CoreLocation

@main
struct WeatherApp: App {
    private let locationManager = LocationManager()
    @StateObject private var viewModel = AppViewModel()
    @State private var location: CLLocation?
    
    private let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let locationName = viewModel.locationName, let current = viewModel.current, let hours = viewModel.hours, let tomorrow = viewModel.tomorrow, let next7Days = viewModel.next7Days {
                    TodayScreen(locationName: locationName, current: current, hours: hours, tomorrow: tomorrow, next7Days: next7Days, withLocation: location != nil)
                } else if viewModel.loading == false, viewModel.error != nil {
                    ErrorView(message: {
                        Text("It was not possible to get the weather information.\nPlease try again in a minute!")
                    }, buttonLabel: {
                        Text("Try again")
                    }) {
                        viewModel.fetch(latitude: location?.coordinate.latitude, longitude: location?.coordinate.longitude)
                    }
                } else {
                    LoadingView()
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("Background"))
            .onAppear {
                locationManager.watchLocationChange { location in
                    self.location = location
                    viewModel.fetch(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                } onError: { error in
                    self.location = nil
                    viewModel.fetch(latitude: nil, longitude: nil)
                }
            }
        }
    }
}

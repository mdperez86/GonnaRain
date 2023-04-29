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
    @StateObject private var viewModel = TodayViewModel()
    @State private var locationError: LocationError?
    @State private var location: CLLocation?
    
    private let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let locationName = viewModel.locationName, let current = viewModel.current, let hours = viewModel.hours, let tomorrow = viewModel.tomorrow, let next7Days = viewModel.next7Days {
                    TodayScreen(locationName: locationName, current: current, hours: hours, tomorrow: tomorrow, next7Days: next7Days)
                } else if viewModel.loading == false, viewModel.error != nil {
                    ErrorView(message: {
                        Text("It was not possible to get the weather information.\nPlease try again in a minute!")
                    }, buttonLabel: {
                        Text("Try again")
                    }) {
                        if let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude {
                            viewModel.fetch(latitude: latitude, longitude: longitude)
                        }
                    }
                } else if locationError != nil {
                    ErrorView(message: {
                        Text("Check the application location permission.")
                    }, buttonLabel: {
                        Text("Go to settings")
                    }) {
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl)
                        }
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
                    locationError = nil
                    viewModel.fetch(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                } onError: { error in
                    locationError = error
                }
            }
        }
    }
}

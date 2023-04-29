//
//  Next7DaysScreen.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 25-04-23.
//

import SwiftUI

struct Next7DaysScreen: View {
    let locationName: String
    let forecastDays: [ForecastDay]
    
    var body: some View {
        List {
            Section("Next \(forecastDays.count) days") {
                ForEach(forecastDays) { forecastday in
                    NavigationLink(destination: DetailsScreen(title: forecastday.localDate.formatted(Date.FormatStyle().day().month(.wide)), subTitle: nil, forecastDay: forecastday)) {
                        HStack(alignment: .center, spacing: 16.0) {
                            ImageView(imageSrc: forecastday.day.condition.imageUrl)
                                .frame(width: 48.0, height: 48.0)
                            
                            VStack(alignment: .leading) {
                                Text(forecastday.localDate.formatted(Date.FormatStyle().weekday(.wide)))
                                    .font(.headline)
                                
                                Text(forecastday.localDate.formatted(Date.FormatStyle().day().month(.wide)))
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text(Measurement(value: forecastday.day.maxtemp_c, unit: UnitTemperature.celsius).formatted())
                                    .font(.headline)
                                
                                Text(Measurement(value: forecastday.day.mintemp_c, unit: UnitTemperature.celsius).formatted())
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .listRowBackground(Color("Card"))
        }
        .navigationTitle(locationName)
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .scrollContentBackground(Visibility.hidden)
        .background(Color("Background"))
    }
}

struct Next7DaysScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Next7DaysScreen(locationName: Location.example.name, forecastDays: [ForecastDay.example, ForecastDay.example])       
        }
    }
}

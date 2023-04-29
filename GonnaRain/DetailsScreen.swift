//
//  DetailsScreen.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 27-04-23.
//

import SwiftUI

struct DetailsScreen: View {
    let title: String
    let subTitle: String?
    let forecastDay: ForecastDay
    
    var body: some View {
        List {
            Section(subTitle != nil ? "Conditions, \(subTitle!)" : "Conditions") {
                HStack {
                    Spacer()
                    
                    ImageView(imageSrc: forecastDay.day.condition.imageUrl)
                        .frame(width: 128, height: 128)
                    
                    Spacer()
                    
                    Text(Measurement(value: forecastDay.day.avgtemp_c, unit: UnitTemperature.celsius).formatted())
                        .font(Font.system(size: 60))
                        .foregroundColor(Color("AccentColor"))
                        .bold()
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
                
                ListItem(imageSrc: "wind", title: {
                    Text("Max wind")
                }, value: {
                    Text(Measurement(value: forecastDay.day.maxwind_kph, unit: UnitSpeed.kilometersPerHour).formatted())
                })
                ListItem(imageSrc: "humidity", title: {
                    Text("Avg humidity")
                }, value: {
                    Text((forecastDay.day.avghumidity / 100).formatted(.percent))
                })
                ListItem(imageSrc: "cloud.rain", title: {
                    Text("Total precipitation")
                }, value: {
                    Text(Measurement(value: forecastDay.day.totalsnow_cm, unit: UnitLength.centimeters).formatted())
                })
                ListItem(imageSrc: "snowflake", title: {
                    Text("Total snow")
                }, value: {
                    Text(Measurement(value: forecastDay.day.totalprecip_mm, unit: UnitLength.millimeters).formatted())
                })
                ListItem(imageSrc: "rays", title: {
                    Text("UV")
                }, value: {
                    Text(forecastDay.day.uv.formatted())
                })
            }
            .listRowBackground(Color("Card"))
            .foregroundColor(Color("Heading"))
            
            Section("Hourly") {
                ForEach(forecastDay.hour) { hour in
                    ListItem(imageSrc: hour.condition.imageUrl, title: {
                        Text(hour.localTime.formatted(date: .omitted, time: .shortened))
                    }, value: {
                        Text(Measurement(value: hour.temp_c, unit: UnitTemperature.celsius).formatted())
                    })
                }
            }
            .listRowBackground(Color("Card"))
            .foregroundColor(Color("Heading"))
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(Visibility.hidden)
        .background(Color("Background"))
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsScreen(title: Location.example.name, subTitle: "Today", forecastDay: ForecastDay.example)
        }
        .environment(\.locale, .init(identifier: "es"))
    }
}

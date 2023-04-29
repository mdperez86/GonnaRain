//
//  ErrorView.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 28-04-23.
//

import SwiftUI

struct ErrorView: View {
    @ViewBuilder let message: () -> Text
    @ViewBuilder let buttonLabel: () -> Text
    var buttonAction: (() -> Void)?
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                
                Image(systemName: "cloud.bolt.rain.fill")
                    .resizable()
                    .foregroundColor(Color("Text"))
                    .scaledToFit()
                    .frame(width: 200)
                
                Spacer()
                
                message()
                    .font(.title2)
                    .foregroundColor(Color("Heading"))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    buttonAction?()
                }, label: {
                    buttonLabel()
                        .padding()
                })
                .buttonStyle(.plain)
                .background(Color("Card"))
                .font(.title.smallCaps())
                .foregroundColor(Color("AccentColor"))
                .cornerRadius(16)
                
                Spacer()
            }
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: {
            Text("Check the application location permission.")
        }, buttonLabel: {
            Text("Go to settings")
        }, buttonAction: {
            print(#function)
        })
        .background(Color("Background"))
        .environment(\.locale, .init(identifier: "es"))
    }
}

//
//  LoadingView.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 28-04-23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                ProgressView()
                    .controlSize(ControlSize.large)
                Spacer()
            }
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .background(Color("Background"))
    }
}

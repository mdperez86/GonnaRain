//
//  ImageView.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 27-04-23.
//

import SwiftUI

struct ImageView: View {
    let imageSrc: String
    
    var body: some View {
        if imageSrc.starts(with: "https://"), let url = URL(string: imageSrc) {
            AsyncImage(url: url) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: imageSrc)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageSrc: "cloud")
    }
}

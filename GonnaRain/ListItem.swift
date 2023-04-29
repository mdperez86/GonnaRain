//
//  ListItem.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 27-04-23.
//

import SwiftUI

struct ListItem: View {
    let imageSrc: String
    @ViewBuilder let title: () -> Text
    @ViewBuilder let value: () -> Text
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            ImageView(imageSrc: imageSrc)
                .frame(width: 32, height: 32)
                .foregroundColor(Color("Heading"))
                .bold()
            title()
                .foregroundColor(Color("Text"))
            Spacer()
            value()
                .bold()
                .foregroundColor(Color("Heading"))
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(imageSrc: "cloud", title: {Text("Hello")}, value: {Text("80")})
    }
}

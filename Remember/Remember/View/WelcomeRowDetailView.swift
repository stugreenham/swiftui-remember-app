//
//  WelcomeRowDetailView.swift
//  Remember
//
//  Created by Stu Greenham on 04/02/2022.
//

import SwiftUI

struct WelcomeRowDetailView: View {
    
    var title: String = "Title"
    var subTitle: String = "Sub Title"
    var imageName: String = "car"

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.colorBrand)
                .padding(8)

            VStack(alignment: .leading) {
                Text(title)
                    //.font(.headline)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top, 4)
    }
    
}

struct WelcomeRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeRowDetailView()
            .previewLayout(.sizeThatFits)
//            .padding()
    }
}

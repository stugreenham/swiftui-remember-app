//
//  ItemAddView.swift
//  Remember
//
//  Created by Stu Greenham on 28/04/2021.
//

import SwiftUI

struct ItemAddView: View {
    var body: some View {
        Group {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
        }
        .padding(12)
        .background(
            Color("color-brand")
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ItemAddView_Previews: PreviewProvider {
    static var previews: some View {
        ItemAddView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

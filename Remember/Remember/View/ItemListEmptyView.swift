//
//  ItemListEmptyView.swift
//  Remember
//
//  Created by Stu Greenham on 27/04/2021.
//

import SwiftUI

struct ItemListEmptyView: View {
    
    //: MARK: - PROPERTIES
    
    
    //: MARK: - BODY
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(.placeholderText))
                    .opacity(0.6)
                
                Text("Nothing to see here")
                    .foregroundColor(Color(.placeholderText))
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 4)
                
                Spacer()
            }
            .offset(y: -24)
            Spacer()
        }
        
    }
}

struct ItemListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListEmptyView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

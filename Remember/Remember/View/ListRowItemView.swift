//
//  ListRowItemView.swift
//  Remember
//
//  Created by Stu Greenham on 28/04/2021.
//

import SwiftUI

struct ListRowItemView: View {
    
    //: MARK: - PROPERTIES

    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    
    //: MARK: - BODY
    
    var body: some View {
        
        VStack(alignment: .leading) {
                
            //: ITEM NAME
            Text(item.name ?? "Unknown")
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 2)
            
            //: ITEM KIND
            Text(item.kind ?? "Unknown")
                .font(.footnote)
                .foregroundColor(.gray)
                
        } //: VSTACK
        .padding(.vertical, 8)

    }
}


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
    
    
    func getSubCopy(kind: String, meta: String) -> String {
        
        // set a base string to return
        var subCopy: String = kind
        
        // modify the base string for a movie entry
        if (kind == "Movie" && meta != "") {
            //print("Meta: \(meta)")
            subCopy = "\(meta) \(kind)" // Action Movie
        }
        
        // modify the base string for a show entry
        if (kind == "TV Show" && meta != "") {
            //print("Meta: \(meta)")
            subCopy = "\(kind) on \(meta)" // Show on Netflix
        }
        
        return subCopy
    }
    
    
    //: MARK: - BODY
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                    
                //: ITEM NAME
                Text(item.name ?? "Unknown")
//                    .font(.headline)
//                    .fontWeight(.bold)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
                
                Spacer()
                    .frame(height: 2)
                
                //: ITEM KIND
                Text(getSubCopy(kind: item.kind ?? "", meta: item.meta ?? ""))
                    .font(.footnote)
                    .foregroundColor(.gray)
                
//                Text("Archived: \(item.archived ? "true":"false")")
//                    .font(.footnote)
                
            } //: VSTACK
            
            Spacer()
            
        } //: HSTACK
        .contentShape(Rectangle())
//        .padding(.vertical, 6)
        .padding(12)
        //.background(Color.gray.opacity(0.1).cornerRadius(8))
        .background(Color.colorCell.cornerRadius(8))
//        .onTapGesture {
//            print(item)
//        }
    }
}
    

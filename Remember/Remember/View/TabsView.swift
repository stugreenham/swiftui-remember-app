//
//  TabsView.swift
//  Remember
//
//  Created by Stu Greenham on 29/10/2021.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        
        TabView {
            
            ContentView(showArchived: false)
                .tabItem {
                    Image(systemName: "bookmark.square")
                    Text("Items")
                }
            
            ContentView(showArchived: true)
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Archive")
                }
            
        }
        
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}

//
//  TabsView.swift
//  Remember
//
//  Created by Stu Greenham on 29/10/2021.
//

import SwiftUI

struct TabsView: View {
    
    //: MARK: - PROPERTIES
    
    // GET LIGHT/DARK MODE
    @Environment(\.colorScheme) var colorScheme
    
    // Hold the state for which tab is active/selected
    @State var selection: Int = 0

    
    
    //: MARK: - BODY
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            ContentView(showArchived: false)
                .tag(0)
//                .tabItem {
//                    Image(systemName: "bookmark.square")
//                    Text("Items")
//                }
            
            ContentView(showArchived: true)
                .tag(1)
//                .tabItem {
//                    Image(systemName: "archivebox")
//                    Text("Archive")
//                }
            
        }
        .overlay( // Overlay the custom TabView component here
            Color(.white) // Base color for Tab Bar
                .edgesIgnoringSafeArea(.vertical)
                .frame(height: 50) // Match Height of native bar
                .overlay(HStack {
                    
                    Spacer()

                    // First Tab Button
                    Button(action: {
                        self.selection = 0
                    }, label: {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                            .opacity(selection == 0 ? 1 : 0.4)
                    })
                    Spacer()

                    // Second Tab Button
                    Button(action: {
                        self.selection = 1
                    }, label: {
                        Image(systemName: "archivebox")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                            .opacity(selection == 1 ? 1 : 0.4)
                    })
                    
                    Spacer()

                })
        ,alignment: .bottom) // Align the overlay to bottom to ensure tab bar stays pinned.
        
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}

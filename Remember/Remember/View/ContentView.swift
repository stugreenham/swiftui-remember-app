//
//  ContentView.swift
//  Remember
//
//  Created by Stu Greenham on 26/04/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //: MARK: - PROPERTIES
    
    @State var name: String = ""
    @State var kind: String = ""
    
    // TOGGLE FOR MODAL SHEET
    @State private var showingSheet = false
    
    // GET LIGHT/DARK MODE
    @Environment(\.colorScheme) var colorScheme
    
    // var to hold the filter type to pass into filteredlistview
    @State private var kindFilter = "All"
    @State private var filterOn: Bool = false
    
    // var to hold the tab bar state (active vs archived)
    var showArchived: Bool = false
    
    
    //: MARK: - BODY
    
    var body: some View {
        NavigationView {
            
            VStack {
                FilteredListView(filter: kindFilter, showArchived: showArchived)
            } //: VSTACK
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                #if os(iOS)
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text(showArchived ? "Archived" : "Remember")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .offset(x: 8)
                }
                
                // FILTER
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    if (!showArchived) {
                        Menu {
                            
                            Button(action: {
                                self.kindFilter = "All"
                                self.filterOn = false
                            }) {
                                Text("All")
                            }
                            
                            Button(action: {
                                self.kindFilter = "App"
                                self.filterOn = true
                            }) {
                                Label("Apps", systemImage: "iphone.homebutton")
                            }
                            
                            Button(action: {
                                self.kindFilter = "Book"
                                self.filterOn = true
                            }) {
                                Label("Books", systemImage: "book")
                            }
                            
                            Button(action: {
                                self.kindFilter = "Movie"
                                self.filterOn = true
                            }) {
                                Label("Movies", systemImage: "film")
                            }
                            
                            Button(action: {
                                self.kindFilter = "TV Show"
                                self.filterOn = true
                            }) {
                                Label("TV Shows", systemImage: "tv")
                            }
                            
                        } label: {
                            Image(systemName: filterOn ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                .offset(x: -4)
                        }
                    } else {
                        EmptyView()
                    }
 
                }
                
                // ADD BUTTON (DISPLAY MODAL)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSheet = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .offset(x: -8)
                    })
                }
                #endif
            }
            .sheet(isPresented: $showingSheet, content: {
                AddItemView(isPresented: $showingSheet)
            })
                
        } //: NAVIGATION
    } //: BODY

    
}


//: MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).preferredColorScheme(.light)
    }
}

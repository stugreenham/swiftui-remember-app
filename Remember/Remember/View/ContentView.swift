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
    
    // var to hold the tab bar state (active vs archived)
    var showArchived: Bool = false
    
    
    //: MARK: - BODY
    
    var body: some View {
        NavigationView {
            
            VStack {
                FilteredListView(filter: kindFilter, showArchived: showArchived)
            } //: VSTACK
//            .navigationBarTitle(showArchived ? "Archived" : "Your Items", displayMode: showArchived ? .inline : .large)
            .navigationBarTitle("", displayMode: .inline)
//            .navigationBarHidden(true)
            .toolbar {
                #if os(iOS)
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text(showArchived ? "Archived" : "Remember")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .offset(x: 12)
                }
                
//                ToolbarItem(placement: .principal) {
//                    HStack {
//                        Image("logo")
//                            .resizable()
//                            .foregroundColor(Color("color-brand"))
//                            .scaledToFill()
//                    }
//                    .frame(width: 16, height: 16)
//                }
                
                // FILTER
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    if (!showArchived) {
                        Menu {
                            
                            Button(action: {
                                self.kindFilter = "All"
                            }) {
                                Text("All") //Label("All", systemImage: "plus.circle")
                            }
                            
                            Button(action: {
                                self.kindFilter = "App"
                            }) {
                                Label("Apps", systemImage: "iphone.homebutton")
                            }
                            
                            Button(action: {
                                self.kindFilter = "Book"
                            }) {
                                Label("Books", systemImage: "book")
                            }
                            
                            Button(action: {
                                self.kindFilter = "Movie"
                            }) {
                                Label("Movies", systemImage: "film")
                            }
                            
                            Button(action: {
                                self.kindFilter = "TV Show"
                            }) {
                                Label("TV Shows", systemImage: "tv")
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .offset(x: -12)
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
                            .offset(x: -12)
                    })
                }
                #endif
            }
            .sheet(isPresented: $showingSheet, content: {
                AddItemView(isPresented: $showingSheet)
            })
                
        } //: NAVIGATION
//        .navigationViewStyle(StackNavigationViewStyle())
    } //: BODY

    
}


//: MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).preferredColorScheme(.light)
    }
}

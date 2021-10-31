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
    
    // FETCHING DATA
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    // TOGGLE FOR MODAL SHEET
    @State private var showingSheet = false
    
    // TOGGLE FOR SHOWING ACTION SHEET
    //@State private var showingActionSheet = false
    
    // VAR TO HOLD TAPPED ITEM DATA
    //@State var itemToDelete: Item?
    
    // GET LIGHT/DARK MODE
    @Environment(\.colorScheme) var colorScheme
    
    // var to hold the filter type to pass into filteredlistview
    @State private var kindFilter = "All"
    
    // var to hold the tab bar state (active vs archived)
    var showArchived: Bool = false
    
    
    
    //: MARK: - FUNCTION

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
    // Delete an item from CoreData
    // From https://www.youtube.com/watch?v=zx3qWNU2NnY&t=1s
//    private func deleteProject(item: Item) {
//        viewContext.delete(item)
//        do {
//            try self.viewContext.save()
//        } catch {
//            let error = error as NSError
//            print(error.debugDescription)
//        }
//
//        //itemToDelete = nil
//    }
    
    
    
    //: MARK: - BODY
    
    var body: some View {
        NavigationView {
            
            VStack {
                FilteredListView(filter: kindFilter, showArchived: showArchived)
                
                
//                List {
//                    ForEach(items) { item in
//
//                        ListRowItemView(item: item)
//                            .swipeActions(edge: .leading) {
//                                Button {
//                                    print("archive item")
//                                } label: {
//                                    Label("Add", systemImage: "archivebox")
//                                }
//                                .tint(.indigo)
//                            }
//                            .swipeActions(edge: .trailing) {
//
//                                // delete item
//                                Button {
//                                    print("delete item \(item.name ?? "")")
//                                    self.deleteProject(item: item)
//                                } label: {
//                                    Label("Delete", systemImage: "trash")
//                                }
//                                .tint(.red)
//
//                                // archive item
//                                Button {
//                                    print("edit item")
//                                } label: {
//                                    Label("Edit", systemImage: "pencil.circle")
//                                }
//                                .tint(.gray)
//
//                            }
//                            .onTapGesture {
//                                self.showingActionSheet = true
//                                //itemToDelete = item
//                                print(item)
//                            }
//
//                    } // LOOP
//                    .onDelete(perform: deleteItems)
//
//                } //: LIST
//                //.listStyle(InsetGroupedListStyle())
//                .listStyle(PlainListStyle())
//                .overlay(
//                    ItemListEmptyView()
//                        .background(colorScheme == .dark ? Color(.systemBackground) : Color(.secondarySystemBackground))
//                        .opacity(items.isEmpty ? 1 : 0)
//                , alignment: .top)
                
            } //: VSTACK
            .navigationBarTitle(showArchived ? "Archived" : "Remember", displayMode: .large)
            .toolbar {
                #if os(iOS)                
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
                    })
                }
                #endif
            }
            .sheet(isPresented: $showingSheet, content: {
                AddItemView(isPresented: $showingSheet)
            })
                
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    } //: BODY

    
}


//: MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).preferredColorScheme(.light)
    }
}

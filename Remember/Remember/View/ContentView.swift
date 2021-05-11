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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // TOGGLE FOR MODAL SHEET
    @State private var showingSheet = false
    
    // GET LIGHT/DARK MODE
    @Environment(\.colorScheme) var colorScheme
    
    
    
    //: MARK: - FUNCTION

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
    //: MARK: - BODY
    
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    ForEach(items) { item in
                        ListRowItemView(item: item)
                    } // LOOP
                    .onDelete(perform: deleteItems)
                    
                } //: LIST
                .listStyle(InsetGroupedListStyle())
                .overlay(
                    ItemListEmptyView()
                        .background(colorScheme == .dark ? Color(.systemBackground) : Color(.secondarySystemBackground))
                        .opacity(items.isEmpty ? 1 : 0)
                , alignment: .top)
            } //: VSTACK
            .navigationBarTitle("Remember", displayMode: .large)
            .toolbar {
                #if os(iOS)
                // EDIT BUTTON
                // ToolbarItem(placement: .navigationBarTrailing) {
                //     EditButton()
                // }
                
                // ADD BUTTON (DISPLAY MODAL)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSheet = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
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

//
//  AddItemView.swift
//  Remember
//
//  Created by Stu Greenham on 26/04/2021.
//

import SwiftUI

struct AddItemView: View {
    
    //: MARK: - PROPERTIES
    
    @State private var name: String = ""
    @State private var kind: String = ""
    @State private var meta: String = ""
    @State var isError: Bool = false
    let kinds = ["App", "Book", "Movie", "Show"]
    let appMeta = ["AppleTV", "Disney+", "Netflix", "Prime", "Other"]
    let movieMeta = ["Drama", "Comedy", "Action", "Fantasy", "Horror", "Romance", "Western", "Thriller"]
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    
    private var isButtonDisabled: Bool {
        name.isEmpty
    }
    
    
    //: MARK: - FUNCTION
    
    private func addItem() {
        withAnimation {
            
            if (name != "" && kind != "")  {
                
                // ADD ITEM TO COREDATA
                let newItem = Item(context: viewContext)
                newItem.id = UUID()
                newItem.timestamp = Date()
                newItem.name = name
                newItem.kind = kind
                newItem.meta = meta
                newItem.completion = false

                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                
                // HIDE SHEET
                self.isPresented = false
                
                // RESET FORM VALUES
                name = ""
                kind = ""
                meta = ""
                feedback.notificationOccurred(.success)
                
            } else {
                feedback.notificationOccurred(.success)
            }
            
        }
    }
    
    
    
    //: MARK: - BODY
    
    var body: some View {
        NavigationView {
            
            Form {
                
                //: ITEM NAME
                TextField("Title", text: $name, onCommit: { if name != "" { addItem() } })
                
                //: ITEM KIND
                Picker("Kind", selection: $kind) {
                    ForEach(kinds, id: \.self) {
                        Text($0)
                    }
                }
                .listStyle(GroupedListStyle())
                
                
                //: OPTIONAL META DATA
                
                if (kind == "Show") {
                    //: ITEM KIND
                    Picker("Platform (Optional)", selection: $meta) {
                        ForEach(appMeta, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                if (kind == "Movie") {
                    //: ITEM KIND
                    Picker("Genre (Optional)", selection: $meta) {
                        ForEach(movieMeta, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
            }
            .navigationBarTitle("Add Item", displayMode: .inline)
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addItem()
                    }, label: {
                        Text("Add")
                    })
                }
                #endif
            }
            
        } //: NAVIGATION
    } //: BODY
}


//: MARK: - PREVIEW

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(isPresented: .constant(true))
    }
}


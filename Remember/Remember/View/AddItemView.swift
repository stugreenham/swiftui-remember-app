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
    @State private var kind: String = "Movie"
    @State var isError: Bool = false
    let kinds = ["App", "Book", "Movie", "Show"]
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    
    private var isButtonDisabled: Bool {
        name.isEmpty
    }
    
    
    //: MARK: - FUNCTION
    
    private func addItem() {
        withAnimation {
            
            if name != "" {
                
                // ADD ITEM TO COREDATA
                let newItem = Item(context: viewContext)
                newItem.id = UUID()
                newItem.timestamp = Date()
                newItem.name = name
                newItem.kind = kind
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
                kind = "Movie"
                feedback.notificationOccurred(.success)
                
            } else {
                feedback.notificationOccurred(.success)
            }
            
        }
    }
    
    
    
    //: MARK: - BODY
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                //: ITEM NAME
                TextField("Name", text: $name, onCommit: { if name != "" { addItem() } })
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 18, weight: .bold))
                    .padding()
                    .background(
                        Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                    .autocapitalization(.words)
                
                //: ITEM KIND
                Picker("Kind", selection: $kind) {
                    ForEach(kinds, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 8)
                
                Spacer()
                
                
            } //: VSTACK
            .navigationBarTitle("Add Item", displayMode: .inline)
            .padding(.horizontal)
            .padding(.vertical, 20)
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


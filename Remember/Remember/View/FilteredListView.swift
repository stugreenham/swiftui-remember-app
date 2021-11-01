//
//  FilteredListView.swift
//  Remember
//
//  Created by Stu Greenham on 29/10/2021.
//

import SwiftUI

struct FilteredListView: View {
    
    //: MARK: - PROPERTIES
    
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<Item>
    @State private var displayEmptyState: Bool = false
    
    
    init(filter: String, showArchived: Bool) {
        //print(String(showArchived))
        
        if (showArchived == false) {
            if (filter == "All") {
                fetchRequest = FetchRequest<Item>(
                    entity: Item.entity(),
                    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
                    predicate: NSPredicate(format: "kind != %@ AND archived == false", filter)
                )
            } else {
                fetchRequest = FetchRequest<Item>(
                    entity: Item.entity(),
                    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
                    predicate: NSPredicate(format: "kind == %@ AND archived == false", filter)
                )
            }
        } else {
            fetchRequest = FetchRequest<Item>(
                entity: Item.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
                predicate: NSPredicate(format: "archived == true")
            )
        }
        
    }
    
    
    //: MARK: - FUNCTIONS
    
    // Archive Item
    private func archiveItem(item: Item) {
        withAnimation {
//            item.archived = true
            item.archived.toggle()
            saveItem()
        }
    }
    
    // Delete Item
    private func deleteItem(item: Item) {
        withAnimation {
            viewContext.delete(item)
            saveItem()
        }
    }
    
    // Save Item
    private func saveItem() {
        do {
            try self.viewContext.save()
            feedback.notificationOccurred(.success)
        } catch {
            let error = error as NSError
            print(error.debugDescription)
        }
    }
    
    
    //: MARK: - BODY
    
    var body: some View {
        
        if fetchRequest.wrappedValue.count == 0 {
            ItemListEmptyView()
            //displayEmptyState = true
        } else {
            
            List {
                ForEach(fetchRequest.wrappedValue, id: \.self) { item in
   
                    ListRowItemView(item: item)
                        .swipeActions(edge: .leading) {
                            // archive item
                            Button {
                                print("archive item")
                                archiveItem(item: item)
                            } label: {
                                Label("Add", systemImage: "archivebox")
                            }
                            .tint(.indigo)

                        }
                        .swipeActions(edge: .trailing) {

                            // delete item
                            Button {
                                print("delete item \(item.name ?? "")")
                                deleteItem(item: item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)

                            // edit item
                            Button {
                                print("edit item")
                            } label: {
                                Label("Edit", systemImage: "pencil.circle")
                            }
                            .tint(.gray)

                        }
                        .onTapGesture {
                            //self.showingActionSheet = true
                            //itemToDelete = item
                            //print(item)
                            print("test")
                            print("fetchRequest.wrappedValue: \(fetchRequest.wrappedValue.count)")
                        }
                } //: FOREACH
                .listRowSeparator(.hidden)
            } //: LIST
            .listStyle(PlainListStyle())
            //        .onTapGesture(perform: {
            //            let resultCount = fetchRequest.wrappedValue.count
            //            print(resultCount)
            //            if resultCount == 0 {
            //                displayEmptyState = true
            //            }
            //        })
            
        } //: IF

        
        
//        .onAppear(perform: {
//            UITableView.appearance().contentInset.top = -40
//        })
        
//        VStack {
//
//            List(fetchRequest.wrappedValue, id: \.self) { item in
//                ListRowItemView(item: item)
////                    .listRowSeparator(.hidden)
//                    .swipeActions(edge: .leading) {
//
//                        // archive item
//                        Button {
//                            print("archive item")
//                            archiveItem(item: item)
//                        } label: {
//                            Label("Add", systemImage: "archivebox")
//                        }
//                        .tint(.indigo)
//
//                    }
//                    .swipeActions(edge: .trailing) {
//
//                        // delete item
//                        Button {
//                            print("delete item \(item.name ?? "")")
//                            deleteItem(item: item)
//                        } label: {
//                            Label("Delete", systemImage: "trash")
//                        }
//                        .tint(.red)
//
//                        // edit item
//                        Button {
//                            print("edit item")
//                        } label: {
//                            Label("Edit", systemImage: "pencil.circle")
//                        }
//                        .tint(.gray)
//
//                    }
//                    .onTapGesture {
//                        //self.showingActionSheet = true
//                        //itemToDelete = item
//                        print(item)
//                    }
//            }
////            .listStyle(PlainListStyle())
////            .listStyle(GroupedListStyle())
////            .listStyle(InsetListStyle())
//        }
////        .padding()
        
    }
}


//: MARK: - PREVIEW

struct FilteredListView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredListView(filter: "All", showArchived: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).preferredColorScheme(.light)
    }
}

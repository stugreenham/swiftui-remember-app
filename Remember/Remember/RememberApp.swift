//
//  RememberApp.swift
//  Remember
//
//  Created by Stu Greenham on 26/04/2021.
//

import SwiftUI

@main
struct RememberApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

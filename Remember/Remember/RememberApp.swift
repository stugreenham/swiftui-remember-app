//
//  RememberApp.swift
//  Remember
//
//  Created by Stu Greenham on 26/04/2021.
//

import SwiftUI

@main
struct RememberApp: App {
    
    @AppStorage("welcomeScreenShown")
    var welcomeScreenShown: Bool = false
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            
            if welcomeScreenShown {
                TabsView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                WelcomeView()
            }
            
        }
    }
}

//
//  Extensions.swift
//  Remember
//
//  Created by Stu Greenham on 04/02/2022.
//

import SwiftUI

// Handle is the welcome screen is shown or not
extension UserDefaults {
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
}

// Make it easier to call custom colours
extension Color {
    static var colorBrand = Color("color-brand")
    static var colorTabIcon = Color("color-tab-icon")
    static var colorTabView = Color("color-tabview")
    static var colorCell = Color("color-cell")
}

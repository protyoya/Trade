

import Foundation

enum Theme: String, CaseIterable, Identifiable {
    case light = "lightTheme"
    case dark = "darkTheme"
    case system = "systemTheme"
    
    var id: String {
        self.rawValue
    }
}

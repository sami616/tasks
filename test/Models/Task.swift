import SwiftUI

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool = false
}


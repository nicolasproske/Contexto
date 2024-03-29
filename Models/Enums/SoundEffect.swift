import SwiftUI

enum SoundEffect: String {
    case start, correct, wrong, reveal, win
}

extension SoundEffect: Identifiable {
    var id: String {
        rawValue
    }
}

import SwiftUI

@Observable
final class Neighbor: Identifiable {
    let id = UUID()
    
    // The word corresponding to the neighbor
    var word: String
    
    // The index corresponding to the neighbor
    var index: Int
    
    // Indicates if the neighbor is revealed, false by default
    var isRevealed: Bool
    
    init(word: String, index: Int, isRevealed: Bool = false) {
        self.word = word
        self.index = index
        self.isRevealed = isRevealed
    }
}

import SwiftUI

@Observable
final class Guess: Identifiable {
    let id = UUID()
    
    // The guessed word
    var word: String
    
    // The index of the guessed word in the list of nearest neighbors of the searched word, -1 if not present
    var index: Int
    
    init(word: String, index: Int) {
        self.word = word
        self.index = index
    }
}

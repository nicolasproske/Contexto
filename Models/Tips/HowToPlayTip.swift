import SwiftUI
import TipKit

struct HowToPlayTip: Tip {
    // The title of the tip
    var title: Text {
        Text("How to play?")
    }
    
    // The description of the tip
    var message: Text? {
        Text("Guess the hidden word. You have unlimited guesses.\n\nIf your guess is one of the 1000 most similar context-related words, you will earn points.\n\nThe 10 closest words can be revealed with those points.")
    }
    
    // The image of the tip
    var image: Image? {
        Image(systemName: "doc.questionmark")
    }
}

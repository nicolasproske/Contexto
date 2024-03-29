import SwiftUI
import NaturalLanguage

struct GuessView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Environment(SoundEffectManager.self) private var soundEffectManager
    
    let game: Game
    
    @Binding var guess: String
    @Binding var guesses: [Guess]
    
    @Binding var points: Int
    
    @Binding var isFinished: Bool
    
    // Action that is executed on finish
    let finishAction: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            inputField
            takeAGuessButton
        }
        .disabled(isFinished)
    }
}

extension GuessView {
    private var inputField: some View {
        TextField("Write down your guess ...", text: $guess)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color(.secondarySystemBackground))
            .multilineTextAlignment(.leading)
            .clipShape(.rect(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 2.0)
            }
            .frame(maxWidth: 300)
    }
    
    private var takeAGuessButton: some View {
        Button {
            // Ensure the text input is not empty even after trimming whitespaces and newlines
            if !guess.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                processGuess()
            }
        } label: {
            Text("Take a guess")
                .prominentButton()
        }
    }
}

extension GuessView {
    // Process the guesssed word
    private func processGuess() {
        // Reduce the lowercased guessed word to its stem
        let currentGuess = lemmatize(word: guess.lowercased())
        
        // Check if the searched word is the guessed word
        if game.searchWord.rawValue == currentGuess {
            finishAction()
            soundEffectManager.play(soundEffect: .win)
            return
        }
        
        let newGuess = Guess(word: currentGuess, index: -1)
        
        // Check if the guessed word is already present
        if guesses.contains(where: { $0.word == currentGuess }) {
            guess = ""
            soundEffectManager.play(soundEffect: .wrong)
            return
        }
        
        // Check if the guessed word is one of the neighbors of the searched word
        if let neighbor = game.neighbors.first(where: { $0.word == currentGuess }) {
            // Ensure the neighbor is not already revealed
            if neighbor.isRevealed {
                guess = ""
                soundEffectManager.play(soundEffect: .wrong)
                return
            }
            
            let index = neighbor.index
            
            // Calculate the points, 1 minimum, else 10 - the index of the guessed word in the neighbors list
            let pointsForGuess = max(10 - index, 1)
            
            newGuess.index = index
            
            withAnimation {
                // Update the points of the user
                points += pointsForGuess
                
                // Reveal the correctly guessed neighbor
                neighbor.isRevealed = true
            }
            
            soundEffectManager.play(soundEffect: .correct)
        } else {
            soundEffectManager.play(soundEffect: .wrong)
        }
        
        // Append the guessed word to the list of other guessed words
        withAnimation {
            guesses.append(newGuess)
        }
        
        // Clear input field
        guess = ""
    }
    
    // Function to lemmatize the given word/string
    private func lemmatize(word: String) -> String {
        // Initialize the NLTagger specifically for lemmatization with the lemma tag scheme
        let tagger = NLTagger(tagSchemes: [.lemma])
        
        // Assign the input word as the string to be processed by the tagger
        tagger.string = word
        
        // Initialize an array to store parts of the lemmatized word
        var lemmatizedString = [String]()
        
        // Enumerate through the tags identified by the tagger within the specified range of the word
        // 'unit: .word' specifies that the tagging should be done on a per-word basis
        // 'scheme: .lemma' specifies that the tagging scheme to use is lemmatization
        tagger.enumerateTags(in: word.startIndex..<word.endIndex, unit: .word, scheme: .lemma) { tag, range in
            // If a lemma tag is found, use its value, else use the original word
            let stem = tag?.rawValue ?? String(word[range])
            
            // Add the lemmatized fragment or the original text to the array
            lemmatizedString.append(stem)
            
            // Return true to continue enumerating tags
            return true
        }
        
        // Join all elements of the lemmatizedString array into a single string and return it
        return lemmatizedString.joined()
    }
}

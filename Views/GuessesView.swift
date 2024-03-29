import SwiftUI

struct GuessesView: View {
    let guesses: [Guess]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your guessed words")
                .capsule(color: .primary)
            
            if guesses.isEmpty {
                ContentUnavailableView("No guesses found", systemImage: "sparkles")
            } else {
                VStack(spacing: 5) {
                    ForEach(guesses) { guess in
                        let index = guess.index + 1
                        let value = guess.word
                        
                        // Valid if the guessed word is in the neighbors list of the searched word
                        let isValid = guess.index != -1
                        let icon = isValid ? "checkmark" : "xmark"
                        let iconForegroundColor: Color = .white
                        let iconBackgroundColor: Color = isValid ? .green : Color(.secondarySystemBackground)
                        
                        ListCellView(index: index, value: value, isBlurred: false, icon: icon, iconForegroundColor: iconForegroundColor, iconBackgroundColor: iconBackgroundColor, isDisabled: true) {
                        }
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

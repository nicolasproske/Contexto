import SwiftUI

struct TopTenNeighborsView: View {
    @Environment(SoundEffectManager.self) private var soundEffectManager
    
    let neighbors: [Neighbor]
    
    @Binding var points: Int
    
    // An alert if the user wants to reveal a neighbor using points
    @State private var showAlert = false
    
    // The index of the neighbor that is to be revealed
    @State private var neighborIndexToReveal: Int?
    
    // Needed points for reveal formatted as a string
    var pointsForReveal: String {
        let pointsNeeded = 10 - neighbors[neighborIndexToReveal ?? 0].index
        return "\(pointsNeeded) \(pointsNeeded == 1 ? "point" : "points")"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Most similar words")
                .capsule(color: .primary)
            
            VStack(spacing: 5) {
                ForEach(neighbors) { neighbor in
                    let index = neighbor.index + 1
                    
                    // Value are random letters if the neighbor isn't revealed yet, else the word
                    let value = neighbor.isRevealed ? neighbor.word : generateRandomLetters(count: neighbor.word.count)
                    
                    let hasEnoughPoints = points >= 10 - neighbor.index
                    let icon = neighbor.isRevealed ? "checkmark" : hasEnoughPoints ? "eye.fill" : "eye.slash.fill"
                    let iconForegroundColor: Color = neighbor.isRevealed ? .white : hasEnoughPoints ? .white : .gray
                    let iconBackgroundColor: Color = neighbor.isRevealed ? .green : hasEnoughPoints ? .accentColor : Color(.secondarySystemBackground)
                    let isDisabled = neighbor.isRevealed || !hasEnoughPoints
                    
                    ListCellView(index: index, value: value, isBlurred: !neighbor.isRevealed, icon: icon, iconForegroundColor: iconForegroundColor, iconBackgroundColor: iconBackgroundColor, isDisabled: isDisabled) {
                        neighborIndexToReveal = neighbor.index
                        showAlert = true
                    }
                }
            }
            .alert("Are you sure?", isPresented: $showAlert) {
                Button("Reveal for \(pointsForReveal)", role: .destructive) {
                    revealNeighbor()
                }
                Button("Cancel", role: .cancel) {
                    neighborIndexToReveal = nil
                }
            } message: {
                Text("Revealing this word costs \(pointsForReveal). Proceed?")
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

extension TopTenNeighborsView {
    // Generate a string of random letters with a specified length
    private func generateRandomLetters(count: Int) -> String {
        // Define the alphabet
        let letters = "abcdefghijklmnopqrstuvwxyz"
        // Initialize an empty string to hold the random letters
        var randomString = ""
        
        // Loop through the number of times equal to the count specified
        for _ in 0..<count {
            // Select a random letter from the alphabet
            if let randomLetter = letters.randomElement() {
                // Append the random letter to the string
                randomString.append(randomLetter)
            }
        }
        
        // Return the string composed of random letters
        return randomString
    }
    
    // Reveals a neighbor based on the index and the user's available points
    private func revealNeighbor() {
        // Ensure that there is an index set for revealing a neighbor
        if let index = neighborIndexToReveal {
            // Access the neighbor at the specified index
            let neighbor = neighbors[index]
            
            // Calculate the cost to reveal the neighbor based on its index
            let costToReveal = 10 - neighbor.index
            
            // Ensure that the user has enough points
            if points >= costToReveal {
                // Deduct the points and reveal the neighbor
                withAnimation { 
                    points -= costToReveal
                    neighbor.isRevealed = true
                }
                
                soundEffectManager.play(soundEffect: .reveal)
            }
        }
        
        // Reset the index
        neighborIndexToReveal = nil
    }
}

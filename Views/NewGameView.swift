import SwiftUI
import NaturalLanguage

struct NewGameView: View {
    @Environment(SoundEffectManager.self) private var soundEffectManager
    
    @Binding var game: Game?
    
    var body: some View {
        Button {
            chooseNewSearchWord()
        } label: {
            Label("Start Contexto", systemImage: "play.fill")
                .prominentButton()
        }
    }
}

extension NewGameView {
    // Choose a new word that is to be guessed
    private func chooseNewSearchWord() {
        // Select a random element from the list of search words
        if let randomSearchWord = SearchWord.allCases.randomElement() {
            createNewGame(for: randomSearchWord)
        }
    }
    
    // Create a new game based on a search word
    private func createNewGame(for searchWord: SearchWord) {
        // Calculate neighbors of the search word
        let neighbors = calculateNeighbors(for: searchWord)
        
        // Create a game instance with the search word and its neighbors
        let game = Game(searchWord: searchWord, neighbors: neighbors)
        
        soundEffectManager.play(soundEffect: .start)
        
        // Assign the created game
        self.game = game
    }
    
    // Calculate the neighbors of a given search word
    private func calculateNeighbors(for searchWord: SearchWord) -> [Neighbor] {
        // Convert the search word to lowercase to ensure consistency
        let searchWord = searchWord.rawValue.lowercased()
        
        // Check if the word embedding is available and the search word is contained within it
        if let embedding = NLEmbedding.wordEmbedding(for: .english), embedding.contains(searchWord) {
            // Attempt to retrieve the vector representation of the search word from the embedding
            if let vector = embedding.vector(for: searchWord) {
                // Retrieve up to 1000 neighbors (closest words) based on the search word's vector
                let neighbors = embedding.neighbors(for: vector, maximumCount: 1000)
                
                // Convert to a list of neighbor instances and return it
                return neighbors.enumerated().map({ (index, neighbor) in
                    return Neighbor(word: neighbor.0, index: index)
                })
            }
        }
        
        // Return an empty array if the embedding is not available or the search word is not found
        return []
    }
}

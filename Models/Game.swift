import SwiftUI

@Observable
final class Game: Identifiable {
    let id = UUID()
    
    // The word that is to be guessed
    var searchWord: SearchWord
    
    // The up to 1000 nearest neighbors of the searched word
    var neighbors: [Neighbor]
    
    init(searchWord: SearchWord, neighbors: [Neighbor]) {
        self.searchWord = searchWord
        self.neighbors = neighbors
    }
}

extension Game {
    // The ten nearest neighbors of the searched word sorted ascending by index
    var topTenSortedNeighbors: [Neighbor] {
        neighbors.prefix(10).sorted(by: { $0.index < $1.index })
    }
}

extension Game: Equatable {
    static func ==(lhs: Game, rhs: Game) -> Bool {
        lhs.id == rhs.id
    }
}

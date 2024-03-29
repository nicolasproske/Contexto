import SwiftUI

enum SearchWord: String, CaseIterable {
    case apple, mountain, piano, eagle, motorcycle, rose, book, cheese, soccer
    
    // A context-related hint of the searched word
    var context: String {
        switch self {
        case .apple:
            return "a fruit associated the discovery of gravity"
        case .mountain:
            return "a natural elevation of the earth's surface"
        case .piano:
            return "a musical instrument with keys"
        case .eagle:
            return "a bird known for its keen eyesight"
        case .motorcycle:
            return "a two-wheeled vehicle that is nimble"
        case .rose:
            return "a flower symbolizing love"
        case .book:
            return "a source of knowledge or entertainment"
        case .cheese:
            return "a dairy product that comes in many varieties"
        case .soccer:
            return "a popular team sport played with a ball"
        }
    }
}

extension SearchWord: Identifiable {
    var id: String {
        rawValue
    }
}

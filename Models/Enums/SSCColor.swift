import SwiftUI

enum SSCColor: String, CaseIterable {
    case orange, pink, purple, darkBlue, lightBlue, lightGreen
    
    // The color corresponding to a hex code
    var color: Color {
        switch self {
        case .orange:
            return Color(hex: 0xfd5d00)
        case .pink:
            return Color(hex: 0xb143ae)
        case .purple:
            return Color(hex: 0x451ea9)
        case .darkBlue:
            return Color(hex: 0x272acf)
        case .lightBlue:
            return Color(hex: 0x00a0fd)
        case .lightGreen:
            return Color(hex: 0x009966)
        }    
    }
}

extension SSCColor: Identifiable {
    var id: String {
        rawValue
    }
}

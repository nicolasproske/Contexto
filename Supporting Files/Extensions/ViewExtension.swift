import SwiftUI

extension View {
    // Returns a view styled like a prominent button
    func prominentButton() -> some View {
        self.modifier(ButtonViewModifier())
    }
    
    // Returns a view styled like a bordered capsule
    func capsule(color: Color = .white) -> some View {
        self.modifier(CapsuleViewModifier(color: color))
    }
    
    // Returns a view styled like a colored capsule
    func coloredCapsule(color: Color) -> some View {
        self.modifier(ColoredCapsuleViewModifier(color: color))
    }
}

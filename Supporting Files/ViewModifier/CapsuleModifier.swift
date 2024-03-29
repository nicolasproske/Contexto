import SwiftUI

// A view styled like a bordered capsule
struct CapsuleViewModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .fontDesign(.rounded)
            .padding(.horizontal, 18)
            .padding(.vertical, 8)
            .overlay {
                Capsule()
                    .stroke(color, lineWidth: 2)
            }
    }
}

// A view styled like a colored capsule
struct ColoredCapsuleViewModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .fontDesign(.monospaced)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .foregroundStyle(color)
            .background(color.opacity(0.2))
            .clipShape(.capsule)
            .overlay {
                Capsule()
                    .stroke(color, lineWidth: 2)
            }
    }
}

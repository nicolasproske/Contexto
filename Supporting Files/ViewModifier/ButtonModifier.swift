import SwiftUI

// A view styled like a prominent button
struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.accentColor)
            .clipShape(.capsule)
    }
}

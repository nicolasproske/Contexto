import SwiftUI

struct InfoBadgeView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .contentTransition(.numericText())
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color(.secondarySystemBackground))
        .clipShape(.rect(cornerRadius: 12))
    }
}

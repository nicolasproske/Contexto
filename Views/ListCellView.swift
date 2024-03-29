import SwiftUI

struct ListCellView: View {
    let index: Int
    let value: String
    let isBlurred: Bool
    let icon: String
    let iconForegroundColor: Color
    let iconBackgroundColor: Color
    let isDisabled: Bool
    
    // Action that is executed on icon tap
    let onIconAction: () -> Void
    
    var body: some View {
        HStack(spacing: 5) {
            indexContent
            
            valueContent
            
            if isBlurred {
                Button {
                    onIconAction()
                } label: {
                    iconContent
                }
                .disabled(isDisabled)
            } else {
                iconContent
            }
        }
        .frame(height: 35)
    }
}

extension ListCellView {
    private var indexContent: some View {
        Text("\(index == 0 ? "?" : "\(index)")")
            .fontDesign(.monospaced)
            .padding(.vertical, 5)
            .frame(width: 50, height: 35)
            .background(Color(.secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 4))
    }
    
    private var valueContent: some View {
        Text(value)
            .fontDesign(.monospaced)
            .lineLimit(1)
            .blur(radius: isBlurred ? 3 : 0)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, minHeight: 35)
            .background(Color(.secondarySystemBackground).opacity(0.3))
            .clipShape(.rect(cornerRadius: 4))
    }
    
    private var iconContent: some View {
        Image(systemName: icon)
            .fontWeight(.bold)
            .foregroundStyle(iconForegroundColor)
            .padding(.vertical, 5)
            .frame(width: 50, height: 35)
            .background(iconBackgroundColor)
            .clipShape(.rect(cornerRadius: 4))
    }
}

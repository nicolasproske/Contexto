import SwiftUI

struct PointsView: View {
    let points: Int
    
    var body: some View {
        InfoBadgeView(title: "Gained Points", value: "\(points)")
    }
}

import SwiftUI

/// Compact progress path - shows journey and collected bravery stars
struct AdventureProgressView: View {
    @EnvironmentObject var state: AdventureState
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 2) {
                Text("⭐")
                    .font(.system(size: 12))
                Text("\(state.starCount)/7")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColor.textPrimary)
            }
            
            // Filling progress bar - game-like
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(red: 0.82, green: 0.9, blue: 0.88))
                        .frame(height: 6)
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 1, green: 0.8, blue: 0.3), AppColor.teal],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(0, geo.size.width * CGFloat(state.starCount) / 7), height: 6)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: state.starCount)
                }
            }
            .frame(height: 6)
            .frame(maxWidth: 180)
            
            HStack(spacing: 4) {
                ForEach(1..<8, id: \.self) { i in
                    StarIconView(filled: state.collectedStars.contains(i))
                }
            }
        }
        .padding(12)
    }
}

private struct StarIconView: View {
    let filled: Bool
    @State private var popScale: CGFloat = 1
    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
            .font(.system(size: 12))
            .foregroundStyle(filled ? Color(red: 1, green: 0.8, blue: 0.3) : Color(red: 0.78, green: 0.85, blue: 0.82))
            .scaleEffect(popScale)
            .onChange(of: filled) { _, isNowFilled in
                if isNowFilled {
                    popScale = 1.4
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.5)) { popScale = 1 }
                }
            }
    }
}

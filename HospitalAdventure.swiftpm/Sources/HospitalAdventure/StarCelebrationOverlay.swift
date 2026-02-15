import SwiftUI

/// Brief star pop when a new bravery star is earned
struct StarCelebrationOverlay: View {
    let starIndex: Int
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 1
    
    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { i in
                Image(systemName: "sparkle")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(red: 1, green: 0.8, blue: 0.3))
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .offset(
                        x: cos(Double(i) * .pi / 3) * 40,
                        y: sin(Double(i) * .pi / 3) * 40
                    )
            }
            Image(systemName: "star.fill")
                .font(.system(size: 32))
                .foregroundStyle(Color(red: 1, green: 0.8, blue: 0.3))
                .scaleEffect(scale)
                .opacity(opacity)
            Text("+1")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .scaleEffect(scale)
                .opacity(opacity)
                .offset(y: 28)
        }
        .onAppear {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.6)) {
                scale = 1
            }
            withAnimation(.easeOut(duration: 0.5).delay(0.6)) {
                opacity = 0
            }
        }
    }
}

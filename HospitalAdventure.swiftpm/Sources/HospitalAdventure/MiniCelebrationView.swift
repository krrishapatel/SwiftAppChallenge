import SwiftUI

/// Reusable sparkle burst - no words, pure visual reward
struct MiniCelebrationView: View {
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 1
    
    var body: some View {
        ZStack {
            ForEach(0..<8, id: \.self) { i in
                Image(systemName: "sparkle")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle([Color(red: 1, green: 0.8, blue: 0.3), AppColor.teal, Color(red: 1, green: 0.9, blue: 0.6)][i % 3])
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .offset(
                        x: cos(Double(i) * .pi / 4) * 35,
                        y: sin(Double(i) * .pi / 4) * 35
                    )
            }
        }
        .onAppear {
            #if os(iOS)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            #endif
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) { scale = 1 }
            withAnimation(.easeOut(duration: 0.4).delay(0.35)) { opacity = 0 }
        }
    }
}

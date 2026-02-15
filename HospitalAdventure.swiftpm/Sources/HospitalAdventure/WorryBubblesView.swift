import SwiftUI

/// Pop your worries away! Tap bubbles to release anxieties — playful, empowering
struct WorryBubblesView: View {
    @Binding var allPopped: Bool
    let onPop: () -> Void
    
    @State private var bubbles: [WorryBubble] = (0..<5).map { i in
        WorryBubble(
            id: i,
            offset: CGSize(width: CGFloat([-40, 20, -15, 35, -25][i]), height: CGFloat([-20, 15, 30, -10, 25][i])),
            size: CGFloat([44, 38, 52, 40, 46][i]),
            delay: Double(i) * 0.08
        )
    }
    
    struct WorryBubble: Identifiable {
        let id: Int
        let offset: CGSize
        let size: CGFloat
        let delay: Double
        var isPopped: Bool = false
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Pop the worry bubbles! 💭✨")
                .font(AppFont.headline)
                .foregroundStyle(AppColor.textPrimary)
            
            Text("Tap each one — worries float away when we notice them!")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(AppColor.textSecondary)
                .multilineTextAlignment(.center)
            
            ZStack {
                ForEach(Array(bubbles.enumerated()), id: \.element.id) { index, bubble in
                    if !bubble.isPopped {
                        BubbleView(
                            size: bubble.size,
                            delay: bubble.delay,
                            onTap: {
                                popBubble(at: index)
                            }
                        )
                        .offset(bubble.offset)
                    }
                }
            }
            .frame(height: 100)
            
            if allPopped {
                ZStack {
                    MiniCelebrationView()
                        .offset(y: -20)
                    Text("All worries popped! You're so brave! 🌟")
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.teal)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .padding(16)
    }
    
    private func popBubble(at index: Int) {
        guard index < bubbles.count, !bubbles[index].isPopped else { return }
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
        onPop()
        
        let b = bubbles[index]
        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
            bubbles[index] = WorryBubble(id: b.id, offset: b.offset, size: b.size, delay: b.delay, isPopped: true)
        }
        
        if bubbles.allSatisfy({ $0.isPopped }) {
            withAnimation(.easeOut(duration: 0.3)) {
                allPopped = true
            }
        }
    }
}

private struct BubbleView: View {
    let size: CGFloat
    let delay: Double
    let onTap: () -> Void
    
    @State private var floatY: CGFloat = 0
    @State private var scale: CGFloat = 0
    @State private var shimmer: CGFloat = 0
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.95),
                                Color(red: 0.88, green: 0.95, blue: 0.98)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.8), lineWidth: 2)
                    )
                    .frame(width: size, height: size)
                    .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
                
                // Soft highlight
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.white.opacity(0.6), Color.clear],
                            center: .topLeading,
                            startRadius: 0,
                            endRadius: size * 0.5
                        )
                    )
                    .frame(width: size, height: size)
            }
        }
        .buttonStyle(PlainScaleStyle())
        .scaleEffect(scale)
        .offset(y: floatY)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(delay)) {
                scale = 1
            }
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true).delay(delay * 2)) {
                floatY = 4
            }
        }
    }
}

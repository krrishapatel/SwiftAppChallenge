import SwiftUI

/// Wraps Luma with tap-to-wiggle easter egg (3 taps = surprise bounce)
struct TappableLumaView: View {
    let mood: PipMood
    var size: CGFloat = 100
    
    @State private var tapCount = 0
    @State private var wiggleRotation: Double = 0
    
    var body: some View {
        Button {
            tapCount += 1
            #if os(iOS)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            #endif
            if tapCount >= 3 {
                triggerWiggle()
                tapCount = 0
            }
        } label: {
            PipCharacter(mood: mood, size: size)
                .rotationEffect(.degrees(wiggleRotation))
        }
        .buttonStyle(.plain)
    }
    
    private func triggerWiggle() {
        withAnimation(.spring(response: 0.15, dampingFraction: 0.3)) {
            wiggleRotation = 15
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.15, dampingFraction: 0.3)) {
                wiggleRotation = -15
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                wiggleRotation = 0
            }
        }
    }
}

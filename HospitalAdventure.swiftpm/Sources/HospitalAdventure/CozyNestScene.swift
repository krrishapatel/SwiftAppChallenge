import SwiftUI

struct CozyNestScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasWokenPip: Bool = false
    @State private var wakeSparkles: Bool = false
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Cozy Nest")
                .font(AppFont.title)
                .foregroundStyle(Color(red: 0.2, green: 0.42, blue: 0.48))
            
            ZStack {
                PipCharacter(mood: hasWokenPip ? .calm : .sleepy, size: 110)
                if wakeSparkles {
                    ForEach(0..<4, id: \.self) { i in
                        Image(systemName: "sparkle")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color(red: 1, green: 0.85, blue: 0.5))
                            .offset(
                                x: cos(Double(i) * .pi / 2) * 55,
                                y: sin(Double(i) * .pi / 2) * 55
                            )
                    }
                }
            }
            
            LumasBraveTipView(scene: .cozyNest)
                .padding(.horizontal, 20)
            
            PipSpeechBubble(
                text: "When you wake up, you'll be in the Cozy Nest. Mom or Dad will be right there. You might feel a little sleepy — that's totally normal!"
            )
            
            if !hasWokenPip {
                Text("Tap Luma to wake them up! ✨")
                    .font(AppFont.caption)
                    .foregroundStyle(AppColor.textSecondary)
            }
            
            Button {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    hasWokenPip = true
                    wakeSparkles = true
                }
            } label: {
                PipCharacter(mood: hasWokenPip ? .calm : .sleepy, size: 80)
            }
            .buttonStyle(.plain)
            .disabled(hasWokenPip)
            
            if hasWokenPip {
                PipSpeechBubble(text: "I'm back! The adventure worked! \(displayName), we did it together!")
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
            
            Spacer()
            
            AdventureButton(title: "Continue") { state.advanceToNextScene() }
                .padding(.bottom, 40)
        }
        .padding(.top, 24)
    }
}

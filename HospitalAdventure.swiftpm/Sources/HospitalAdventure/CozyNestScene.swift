import SwiftUI

struct CozyNestScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasWokenPip: Bool = false
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Cozy Nest")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            PipCharacter(mood: hasWokenPip ? .calm : .sleepy, size: 110)
            
            PipSpeechBubble(
                text: "When you wake up, you'll be in the Cozy Nest. Mom or Dad will be right there. You might feel a little sleepy — that's totally normal!"
            )
            
            if !hasWokenPip {
                Text("Tap Pip to wake them up!")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.45))
            }
            
            Button {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    hasWokenPip = true
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
            
            AdventureButton(title: "Continue") {
                state.advanceToNextScene()
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .padding(.top, 24)
    }
}

import SwiftUI

struct ChangingRoomScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasDressedPip: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Changing Room")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            PipCharacter(mood: hasDressedPip ? .calm : .curious, size: 110)
                .overlay(
                    // Adventure pajamas overlay when dressed
                    Group {
                        if hasDressedPip {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.5, green: 0.7, blue: 0.9), lineWidth: 3)
                                .frame(width: 70, height: 90)
                                .offset(y: 10)
                        }
                    }
                )
            
            PipSpeechBubble(
                text: "You'll put on special pajamas. They're soft and cozy — everyone wears them. You'll look like the other adventurers!"
            )
            
            if !hasDressedPip {
                Text("Tap Pip to try on the adventure pajamas!")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.45))
            }
            
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    hasDressedPip = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(hasDressedPip ? Color(red: 0.35, green: 0.65, blue: 0.45).opacity(0.5) : Color(red: 0.6, green: 0.85, blue: 0.7))
                        .frame(width: 120, height: 60)
                    Text(hasDressedPip ? "Ooh, comfy!" : "Try them on!")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.2, green: 0.35, blue: 0.3))
                }
            }
            .buttonStyle(.plain)
            .disabled(hasDressedPip)
            
            if hasDressedPip {
                PipSpeechBubble(text: "Ooh, comfy! I feel like a real adventurer now!")
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

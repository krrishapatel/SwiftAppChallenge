import SwiftUI

struct CheckInNestScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasTappedCheck: Bool = false
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Check-In Nest")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            HStack(alignment: .bottom, spacing: 20) {
                PipCharacter(mood: hasTappedCheck ? .calm : .curious, size: 90)
                
                // Guardian (nurse) - simplified figure
                VStack(spacing: 4) {
                    Circle()
                        .fill(Color(red: 0.9, green: 0.85, blue: 0.75))
                        .frame(width: 40, height: 40)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 0.4, green: 0.7, blue: 0.9))
                        .frame(width: 50, height: 50)
                    // Clipboard
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white)
                        .frame(width: 30, height: 35)
                        .overlay(
                            Image(systemName: "list.bullet")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        )
                }
            }
            .padding(.vertical, 8)
            
            PipSpeechBubble(
                text: "A Guardian will ask your name and maybe check your temperature. They're just making sure you're ready. It's quick!"
            )
            
            if !hasTappedCheck {
                Text("Tap Pip to help them get checked!")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.45))
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    hasTappedCheck = true
                }
            } label: {
                PipCharacter(mood: hasTappedCheck ? .calm : .curious, size: 80)
            }
            .buttonStyle(.plain)
            .disabled(hasTappedCheck)
            
            if hasTappedCheck {
                PipSpeechBubble(text: "You did it! That wasn't scary at all. Thank you!")
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

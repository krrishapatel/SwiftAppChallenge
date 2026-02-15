import SwiftUI

struct CheckInNestScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasTappedCheck: Bool = false
    @State private var showClipboard: Bool = false
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Check-In Nest")
                .font(AppFont.title)
                .foregroundStyle(Color(red: 0.2, green: 0.42, blue: 0.48))
            
            // Luma + Friendly Guardian
            HStack(alignment: .center, spacing: 16) {
                PipCharacter(mood: hasTappedCheck ? .calm : .curious, size: 85)
                
                VStack(spacing: 4) {
                    GuardianCharacter(size: 90)
                    
                    if showClipboard {
                        Text("Hi \(displayName)!")
                            .font(AppFont.caption)
                            .foregroundStyle(Color(red: 0.35, green: 0.55, blue: 0.6))
                    }
                }
            }
            .padding(.vertical, 8)
            
            LumasBraveTipView(scene: .checkInNest)
                .padding(.horizontal, 20)
            
            PipSpeechBubble(
                text: checkInMessage
            )
            
            if !hasTappedCheck {
                Text("Tap Luma to help them get checked! ✨")
                    .font(AppFont.caption)
                    .foregroundStyle(Color(red: 0.4, green: 0.55, blue: 0.58))
            }
            
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    hasTappedCheck = true
                    showClipboard = true
                }
            } label: {
                PipCharacter(mood: hasTappedCheck ? .calm : .curious, size: 75)
            }
            .buttonStyle(.plain)
            .disabled(hasTappedCheck)
            
            if hasTappedCheck {
                PipSpeechBubble(text: "You did it! That wasn't scary at all. The Guardian is so nice. Thank you!")
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.9).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
            
            Spacer()
            
            AdventureButton(title: "Continue") { state.advanceToNextScene() }
                .padding(.bottom, 40)
        }
        .padding(.top, 24)
    }
    
    private var checkInMessage: String {
        var msg = "A friendly Guardian will say hello and ask your name. They might check your temperature too — just a quick peek!"
        if let hint = state.procedureType.customHint {
            msg += " \(hint)"
        }
        return msg
    }
}

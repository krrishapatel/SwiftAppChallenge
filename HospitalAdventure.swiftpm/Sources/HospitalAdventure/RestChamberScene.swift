import SwiftUI

struct RestChamberScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasPutOnMask: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Rest Chamber")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            ZStack {
                // Rest Chamber - bed outline
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.5, green: 0.7, blue: 0.6), lineWidth: 3)
                    .frame(width: 200, height: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.5))
                    )
                
                PipCharacter(mood: hasPutOnMask ? .sleepy : .calm, size: 70)
                    .offset(y: -10)
                
                // Dream Mist mask overlay
                if hasPutOnMask {
                    Ellipse()
                        .stroke(Color(red: 0.6, green: 0.8, blue: 0.9), lineWidth: 4)
                        .frame(width: 50, height: 35)
                        .offset(y: -25)
                }
            }
            .padding(.vertical, 16)
            
            PipSpeechBubble(
                text: "This is where you take a special nap. A Guardian will give you Dream Mist — it might smell a little funny, but that's okay. You'll fall asleep fast."
            )
            
            if !hasPutOnMask {
                Text("Tap to help Pip try the Dream Mist!")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.45))
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    hasPutOnMask = true
                }
            } label: {
                ZStack {
                    Ellipse()
                        .fill(Color(red: 0.7, green: 0.9, blue: 0.95))
                        .frame(width: 80, height: 50)
                    Text("Dream Mist")
                        .font(.caption)
                        .foregroundColor(Color(red: 0.3, green: 0.5, blue: 0.6))
                }
            }
            .buttonStyle(.plain)
            .disabled(hasPutOnMask)
            
            if hasPutOnMask {
                PipSpeechBubble(
                    text: "When you wake up, the hard part is done. Mom or Dad will be right there. Sweet dreams!"
                )
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

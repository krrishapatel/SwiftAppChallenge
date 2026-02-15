import SwiftUI

struct CourageVinesScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasHeldHand: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Courage Vines")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            ZStack(alignment: .leading) {
                PipCharacter(mood: hasHeldHand ? .calm : .nervous, size: 100)
                
                // Courage Vine (IV) - soft green tube
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.5, green: 0.8, blue: 0.6),
                                    Color(red: 0.4, green: 0.7, blue: 0.5)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 60, height: 8)
                    Circle()
                        .fill(Color(red: 0.45, green: 0.75, blue: 0.55))
                        .frame(width: 16, height: 16)
                }
                .offset(x: 90, y: 20)
            }
            
            PipSpeechBubble(
                text: "A Guardian might put a tiny tube in your hand. It's called a Courage Vine. I was nervous... but it's just a small pinch. Want to hold my hand?"
            )
            
            if !hasHeldHand {
                Text("Tap to hold Pip's hand!")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.45))
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    hasHeldHand = true
                }
            } label: {
                Image(systemName: "hand.raised.fill")
                    .font(.system(size: 44))
                    .foregroundColor(Color(red: 0.6, green: 0.75, blue: 0.65))
            }
            .buttonStyle(.plain)
            .disabled(hasHeldHand)
            
            if hasHeldHand {
                PipSpeechBubble(text: "Thank you. That helped! This brings special medicine to help you rest. You're so brave.")
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

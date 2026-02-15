import SwiftUI

struct BraveryCeremonyScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var showBadge: Bool = false
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Bravery Ceremony")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            PipCharacter(mood: .proud, size: 120)
            
            PipSpeechBubble(
                text: "\(displayName), you completed the Healing Grove adventure! You're so brave. I'm proud of you. We did it together!"
            )
            
            // Bravery Badge
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.95, green: 0.9, blue: 0.6),
                                Color(red: 0.9, green: 0.8, blue: 0.4)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 140, height: 140)
                    .overlay(
                        Circle()
                            .stroke(Color(red: 0.6, green: 0.5, blue: 0.2), lineWidth: 4)
                    )
                
                VStack(spacing: 4) {
                    Text("⭐")
                        .font(.system(size: 44))
                    Text("BRAVE")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.4, green: 0.3, blue: 0.1))
                }
            }
            .scaleEffect(showBadge ? 1 : 0.5)
            .opacity(showBadge ? 1 : 0)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    showBadge = true
                }
            }
            
            PipSpeechBubble(
                text: "Draw your own badge or print this to bring with you! See you at the real Healing Grove. I'll be with you. 💚"
            )
            
            Spacer()
            
            VStack(spacing: 16) {
                AdventureButton(title: "Start Over") {
                    state.resetAdventure()
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .padding(.top, 24)
    }
}

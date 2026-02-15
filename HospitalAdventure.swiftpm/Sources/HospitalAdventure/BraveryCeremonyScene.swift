import SwiftUI

struct BraveryCeremonyScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var certificateScale: CGFloat = 0.5
    @State private var certificateOpacity: Double = 0
    @State private var confettiScale: CGFloat = 0
    @State private var lumaBounce: Bool = false
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                PipCharacter(mood: .proud, size: 100)
                    .scaleEffect(lumaBounce ? 1.05 : 1)
                
                LumasBraveTipView(scene: .braveryCeremony)
                    .padding(.horizontal, 20)
                
                PipSpeechBubble(
                    text: "\(displayName), you did it! You collected \(state.starCount) bravery stars! I'm so proud of you — we did it together! 🌟"
                )
                
                // Personalized Certificate - creative, certificate-style
                ZStack {
                    // Certificate frame with decorative border
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.98, green: 0.96, blue: 0.92),
                                    Color(red: 0.95, green: 0.93, blue: 0.88)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.6, green: 0.75, blue: 0.7),
                                            Color(red: 0.5, green: 0.65, blue: 0.6)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 4
                                )
                        )
                        .shadow(color: .black.opacity(0.08), radius: 16, y: 6)
                    
                    VStack(spacing: 12) {
                        // Decorative top
                        HStack(spacing: 6) {
                            ForEach(0..<5, id: \.self) { i in
                                Image(systemName: "leaf.fill")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color(red: 0.5, green: 0.72, blue: 0.62))
                            }
                        }
                        
                        Text("🎉")
                            .font(.system(size: 36))
                        
                        Text("OFFICIAL CERTIFICATE")
                            .font(.system(size: 12, weight: .heavy, design: .rounded))
                            .tracking(2)
                            .foregroundStyle(Color(red: 0.4, green: 0.55, blue: 0.5))
                        
                        Text("Healing Grove Adventurer")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 0.25, green: 0.4, blue: 0.45))
                        
                        Text("This certifies that")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(Color(red: 0.45, green: 0.5, blue: 0.52))
                        
                        Text(displayName)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.3, green: 0.55, blue: 0.6),
                                        Color(red: 0.25, green: 0.45, blue: 0.5)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("has bravely explored the Healing Grove\nand is ready for their hospital adventure!")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color(red: 0.5, green: 0.55, blue: 0.58))
                        
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(Color(red: 1, green: 0.8, blue: 0.3))
                            Text("Signed, Luma")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(red: 0.5, green: 0.65, blue: 0.7))
                        }
                        .padding(.top, 4)
                    }
                    .padding(28)
                }
                .frame(maxWidth: 320)
                .scaleEffect(certificateScale)
                .opacity(certificateOpacity)
                
                // Confetti burst
                ZStack {
                    ForEach(0..<12, id: \.self) { i in
                        Image(systemName: ["star.fill", "heart.fill", "sparkle"][i % 3])
                            .font(.system(size: 14))
                            .foregroundStyle([
                                Color(red: 1, green: 0.75, blue: 0.4),
                                Color(red: 0.6, green: 0.85, blue: 0.75),
                                Color(red: 0.7, green: 0.8, blue: 1)
                            ][i % 3])
                            .scaleEffect(confettiScale)
                            .offset(
                                x: cos(Double(i) * .pi / 6) * 90,
                                y: sin(Double(i) * .pi / 6) * 90
                            )
                    }
                }
                .frame(height: 100)
                
                PipSpeechBubble(
                    text: "Bring this with you to the real hospital — or draw your own! I'll be right there with you. You've got this! ✨"
                )
                
                QuestionsForGrownUpsView()
                
                AdventureButton(title: "Start Over") { state.resetAdventure() }
                    .padding(.bottom, 40)
            }
            .padding(.top, 20)
        }
        .onAppear {
            state.collectedStars.insert(AdventureScene.braveryCeremony.rawValue)
            withAnimation(.spring(response: 0.7, dampingFraction: 0.65)) {
                certificateScale = 1
                certificateOpacity = 1
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.3)) {
                confettiScale = 1
                lumaBounce = true
            }
        }
    }
}

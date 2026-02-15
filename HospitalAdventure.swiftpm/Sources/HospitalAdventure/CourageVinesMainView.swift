import SwiftUI

struct CourageVinesMainView: View {
    @EnvironmentObject var state: AdventureState
    @State private var tubeAttached = false
    @State private var handOpacity: Double = 0
    
    var body: some View {
        CourageVinesBody(
            tubeAttached: $tubeAttached,
            handOpacity: $handOpacity,
            state: state
        )
    }
}

struct CourageVinesBody: View {
    @Binding var tubeAttached: Bool
    @Binding var handOpacity: Double
    let state: AdventureState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("The Courage Vines")
                    .font(AppFont.title)
                    .foregroundStyle(Color(red: 0.2, green: 0.42, blue: 0.48))
                
                LumasBraveTipView(scene: .courageVines)
                    .padding(.horizontal, 20)
                
                TubeLumaSection(
                    tubeAttached: tubeAttached,
                    handOpacity: handOpacity,
                    onTap: { attachTube() }
                )
                
                PipSpeechBubble(text: speechText)
                
                if !tubeAttached {
                    Text("Tap the green tube to put it on Luma's hand! 👆")
                        .font(AppFont.caption)
                        .foregroundStyle(Color(red: 0.4, green: 0.55, blue: 0.58))
                }
                
                Spacer(minLength: 20)
                
                HStack(spacing: 16) {
                    Text("💧")
                    Text("Sleepy medicine")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.4, green: 0.55, blue: 0.52))
                    Image(systemName: tubeAttached ? "checkmark.circle.fill" : "arrow.up.circle")
                        .foregroundStyle(AppColor.teal)
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 0.9, green: 0.95, blue: 0.92)))
                .padding(.horizontal, 24)
                
                if tubeAttached {
                    AdventureButton(title: "Continue") { state.advanceToNextScene() }
                        .padding(.bottom, 40)
                }
            }
            .padding(.top, 20)
        }
    }
    
    private var speechText: String {
        let name = state.childName.isEmpty ? "Brave One" : state.childName
        if tubeAttached {
            return "You did it, \(name)! The Courage Vine is on. You're so brave! 💚"
        }
        let base = "A Guardian might put a tiny tube called a Courage Vine in your hand. Ready to try?"
        if state.procedureType == .ears {
            return base + " They might look in your ears first!"
        }
        if state.procedureType == .tummy {
            return base + " They might gently check your tummy too!"
        }
        return base
    }
    
    private func attachTube() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            tubeAttached = true
            handOpacity = 1
        }
    }
}

struct TubeLumaSection: View {
    let tubeAttached: Bool
    let handOpacity: Double
    let onTap: () -> Void
    
    @State private var celebrateScale: CGFloat = 1
    
    var body: some View {
        ZStack {
            PipCharacter(mood: tubeAttached ? .calm : .nervous, size: 100)
                .scaleEffect(celebrateScale)
            
            if tubeAttached {
                MiniCelebrationView()
                tubeShape.offset(x: 60, y: 22)
                Image(systemName: "hand.raised.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(Color(red: 0.96, green: 0.9, blue: 0.82))
                    .opacity(handOpacity)
                    .offset(x: -55, y: 15)
                    .rotationEffect(.degrees(-25))
            } else {
                Button(action: onTap) {
                    tubeShape
                }
                .buttonStyle(PlainScaleStyle())
                .offset(x: 85, y: 5)
            }
        }
        .frame(height: 180)
        .onChange(of: tubeAttached) { _, attached in
            if attached {
                celebrateScale = 1.15
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    celebrateScale = 1
                }
            }
        }
    }
    
    private var tubeShape: some View {
        HStack(spacing: 0) {
            Circle()
                .fill(Color(red: 0.4, green: 0.7, blue: 0.55))
                .frame(width: 16, height: 16)
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 0.55, green: 0.82, blue: 0.68))
                .frame(width: 55, height: 14)
        }
    }
}

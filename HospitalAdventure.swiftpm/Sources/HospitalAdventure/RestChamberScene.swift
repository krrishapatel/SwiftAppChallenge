import SwiftUI

struct RestChamberScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var hasPutOnMask: Bool = false
    @State private var maskScale: CGFloat = 0.5
    @State private var dreamMistPulse: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Rest Chamber")
                .font(AppFont.title)
                .foregroundStyle(Color(red: 0.2, green: 0.42, blue: 0.48))
            
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
                
                // Dream Mist mask overlay - animates in gently
                if hasPutOnMask {
                    Ellipse()
                        .stroke(Color(red: 0.6, green: 0.8, blue: 0.9), lineWidth: 4)
                        .frame(width: 50, height: 35)
                        .offset(y: -25)
                        .scaleEffect(maskScale)
                }
            }
            .padding(.vertical, 16)
            
            LumasBraveTipView(scene: .restChamber)
                .padding(.horizontal, 20)
            
            PipSpeechBubble(
                text: "This is where you take a special nap. A Guardian will give you Dream Mist — it might smell a little funny, but that's okay. You'll fall asleep fast."
            )
            
            if !hasPutOnMask {
                Text("Tap to help Luma try the Dream Mist! ✨")
                    .font(AppFont.caption)
                    .foregroundStyle(AppColor.textSecondary)
            }
            
            Button {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    hasPutOnMask = true
                    maskScale = 1
                }
            } label: {
                ZStack {
                    Ellipse()
                        .fill(Color(red: 0.7, green: 0.9, blue: 0.95))
                        .frame(width: 80, height: 50)
                        .scaleEffect(1 + dreamMistPulse * 0.05)
                    Text("Dream Mist")
                        .font(AppFont.caption)
                        .foregroundStyle(Color(red: 0.3, green: 0.5, blue: 0.6))
                }
            }
            .buttonStyle(PlainScaleStyle())
            .disabled(hasPutOnMask)
            .onAppear {
                if !hasPutOnMask {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        dreamMistPulse = 1
                    }
                }
            }
            
            if hasPutOnMask {
                PipSpeechBubble(
                    text: "When you wake up, the hard part is done. Mom or Dad will be right there. Sweet dreams!"
                )
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
            
            Spacer()
            
            if hasPutOnMask {
                AdventureButton(title: "Continue") { state.advanceToNextScene() }
                    .padding(.bottom, 40)
            }
        }
        .padding(.top, 24)
    }
}

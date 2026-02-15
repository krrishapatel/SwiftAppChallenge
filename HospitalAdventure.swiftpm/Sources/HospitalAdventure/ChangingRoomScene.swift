import SwiftUI

struct ChangingRoomScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var pajamaStage: PajamaStage = .ready
    @State private var selectedGown: GownStyle = .cloud
    @State private var gownOffset: CGFloat = -120
    @State private var gownOpacity: Double = 0
    @State private var sparkleScale: CGFloat = 0
    @State private var hasLookedInMirror = false
    @State private var mirrorShimmer: CGFloat = 0
    @State private var coatRackSway: Double = 0
    @State private var rugPulse: CGFloat = 1
    
    enum PajamaStage {
        case ready
        case puttingOn
        case complete
    }
    
    enum GownStyle: String, CaseIterable {
        case cloud = "Cloud"
        case mint = "Mint"
        case lavender = "Lavender"
        
        var color1: Color {
            switch self {
            case .cloud: return Color(red: 0.55, green: 0.8, blue: 0.95)
            case .mint: return Color(red: 0.5, green: 0.88, blue: 0.75)
            case .lavender: return Color(red: 0.75, green: 0.7, blue: 0.95)
            }
        }
        var color2: Color {
            switch self {
            case .cloud: return Color(red: 0.45, green: 0.72, blue: 0.9)
            case .mint: return Color(red: 0.4, green: 0.78, blue: 0.65)
            case .lavender: return Color(red: 0.65, green: 0.6, blue: 0.9)
            }
        }
        var emoji: String {
            switch self {
            case .cloud: return "☁️"
            case .mint: return "🌿"
            case .lavender: return "💜"
            }
        }
    }
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("The Changing Room")
                    .font(AppFont.title)
                    .foregroundStyle(Color(red: 0.2, green: 0.42, blue: 0.48))
                
                ZStack {
                    PipCharacter(mood: pajamaStage == .complete ? .proud : .curious, size: 120)
                    
                    if pajamaStage != .ready {
                        ZStack {
                            Ellipse()
                                .fill(
                                    LinearGradient(
                                        colors: [selectedGown.color1, selectedGown.color2],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: 75, height: 55)
                                .overlay(
                                    Ellipse()
                                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                                )
                                .opacity(gownOpacity)
                                .offset(y: gownOffset)
                            
                            if pajamaStage == .complete {
                                ForEach(0..<4, id: \.self) { i in
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 8))
                                        .foregroundStyle(Color.white.opacity(0.6))
                                        .offset(
                                            x: CGFloat([-12, 12, -6, 8][i]),
                                            y: 28 + CGFloat([0, 3, 12, 10][i])
                                        )
                                }
                            }
                        }
                    }
                    
                    if pajamaStage == .complete {
                        ForEach(0..<6, id: \.self) { i in
                            Image(systemName: "sparkle")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(Color(red: 1, green: 0.85, blue: 0.5))
                                .scaleEffect(sparkleScale)
                                .offset(
                                    x: cos(Double(i) * .pi / 3) * 75,
                                    y: sin(Double(i) * .pi / 3) * 75
                                )
                        }
                    }
                }
                .frame(height: 160)
                
                LumasBraveTipView(scene: .changingRoom)
                    .padding(.horizontal, 20)
                
                PipSpeechBubble(
                    text: pajamaStage == .ready
                        ? "Pick your favorite Adventure Pajamas, \(displayName)! Then help Luma put them on."
                        : pajamaStage == .complete && !hasLookedInMirror
                        ? "Ta-da! Now tap the mirror — you look amazing! ✨"
                        : "Look at you! You're all dressed and ready. So cozy!"
                )
                
                // Wardrobe - choose gown style
                if pajamaStage == .ready {
                    VStack(spacing: 10) {
                        Text("Choose your pajamas!")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppColor.textPrimary)
                        
                        HStack(spacing: 14) {
                            ForEach(GownStyle.allCases, id: \.self) { style in
                                Button {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                        selectedGown = style
                                    }
                                    #if os(iOS)
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    #endif
                                } label: {
                                    VStack(spacing: 6) {
                                        ZStack {
                                            Ellipse()
                                                .fill(
                                                    LinearGradient(
                                                        colors: [style.color1, style.color2],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                                .frame(width: 44, height: 32)
                                                .overlay(
                                                    Ellipse()
                                                        .stroke(selectedGown == style ? Color.white : Color.clear, lineWidth: 3)
                                                )
                                                .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
                                            Text(style.emoji)
                                                .font(.system(size: 18))
                                        }
                                        Text(style.rawValue)
                                            .font(.system(size: 11, weight: .medium, design: .rounded))
                                            .foregroundStyle(selectedGown == style ? AppColor.teal : AppColor.textSecondary)
                                    }
                                    .frame(width: 70)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(selectedGown == style ? Color(red: 0.9, green: 0.97, blue: 0.94) : Color.white.opacity(0.8))
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        
                        Button {
                            startPajamaAnimation()
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "tshirt.fill")
                                    .font(.system(size: 18))
                                Text("Put them on Luma!")
                                    .font(AppFont.headline)
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 0.5, green: 0.75, blue: 0.9),
                                                Color(red: 0.4, green: 0.65, blue: 0.85)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color(red: 0.4, green: 0.65, blue: 0.8).opacity(0.4), radius: 8, y: 4)
                            )
                        }
                        .buttonStyle(PlainScaleStyle())
                    }
                }
                
                if pajamaStage == .complete {
                    // Mirror moment - tap to "look"
                    Button {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            hasLookedInMirror = true
                            mirrorShimmer = 1
                        }
                        #if os(iOS)
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        #endif
                    } label: {
                        ChangingRoomMirrorView(shimmer: mirrorShimmer)
                    }
                    .buttonStyle(.plain)
                    .disabled(hasLookedInMirror)
                }
                
                // Cozy room elements - fill the space
                ChangingRoomDecorView(
                    coatRackSway: $coatRackSway,
                    rugPulse: $rugPulse,
                    comfortItem: state.chosenComfortItem
                )
                .padding(.top, 8)
                
                if pajamaStage == .complete {
                    AdventureButton(title: "Continue") { state.advanceToNextScene() }
                        .padding(.top, 16)
                        .padding(.bottom, 40)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                coatRackSway = 4
                rugPulse = 1.02
            }
        }
    }
    
    private func startPajamaAnimation() {
        pajamaStage = .puttingOn
        gownOffset = -120
        gownOpacity = 0
        
        withAnimation(.easeOut(duration: 0.9)) {
            gownOffset = 38
            gownOpacity = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            pajamaStage = .complete
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                sparkleScale = 1
            }
        }
    }
}

/// Animated room decor - coat rack, rug, comfort item
private struct ChangingRoomDecorView: View {
    @Binding var coatRackSway: Double
    @Binding var rugPulse: CGFloat
    let comfortItem: ComfortItem
    
    var body: some View {
        ZStack {
            // Soft rug
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.75, green: 0.88, blue: 0.82),
                            Color(red: 0.7, green: 0.85, blue: 0.78)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                )
                .scaleEffect(rugPulse)
            
            HStack(spacing: 40) {
                // Coat rack with swaying coat
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 0.6, green: 0.5, blue: 0.4))
                        .frame(width: 6, height: 50)
                    Image(systemName: "figure.stand.dress.line.vertical.figure")
                        .font(.system(size: 28))
                        .foregroundStyle(Color(red: 0.5, green: 0.7, blue: 0.6))
                        .rotationEffect(.degrees(coatRackSway))
                }
                
                // Comfort item waiting (personalized!)
                VStack(spacing: 4) {
                    Text(comfortItem.emoji)
                        .font(.system(size: 32))
                    Text("Your \(comfortItem.rawValue)")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(AppColor.textSecondary)
                }
                
                // Pajama bag
                VStack(spacing: 4) {
                    Image(systemName: "bag.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Color(red: 0.55, green: 0.75, blue: 0.65))
                    Text("Ready!")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(AppColor.textSecondary)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

/// Tap-to-look mirror
private struct ChangingRoomMirrorView: View {
    let shimmer: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.92, green: 0.95, blue: 0.98),
                            Color(red: 0.88, green: 0.92, blue: 0.96)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 140, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.9),
                                    Color(red: 0.7, green: 0.85, blue: 0.8).opacity(0.5)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                )
            
            VStack(spacing: 6) {
                Text("🪞")
                    .font(.system(size: 28))
                Text("Look at you!")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.35, green: 0.5, blue: 0.55))
            }
            .opacity(0.7 + shimmer * 0.3)
        }
    }
}

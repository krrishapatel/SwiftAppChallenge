import SwiftUI

/// Luma - a soft, glowing bravery buddy for the Healing Grove
enum PipMood {
    case nervous
    case curious
    case calm
    case proud
    case sleepy
}

struct PipCharacter: View {
    let mood: PipMood
    var size: CGFloat = 120
    var animateIdle: Bool = true
    
    @State private var floatOffset: CGFloat = 0
    @State private var glowPulse: CGFloat = 0
    @State private var nervousTilt: Double = 0
    @State private var sparkleOpacity: Double = 0
    
    private var isEyesClosed: Bool { mood == .sleepy }
    
    private var smileAmount: CGFloat {
        switch mood {
        case .nervous: return 0.3
        case .curious: return 0.7
        case .calm, .proud: return 0.9
        case .sleepy: return 0.5
        }
    }
    
    var body: some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            lumaColor.opacity(0.4),
                            lumaColor.opacity(0.15),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: size * 0.2,
                        endRadius: size * 0.7
                    )
                )
                .frame(width: size * 1.4, height: size * 1.4)
                .blur(radius: 20)
                .scaleEffect(1 + glowPulse * 0.08)
            
            // Main body - soft rounded orb
            ZStack {
                // Base - soft gradient sphere
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.white.opacity(0.95),
                                lumaColor.opacity(0.9),
                                lumaColor.opacity(0.75)
                            ],
                            center: UnitPoint(x: 0.35, y: 0.35),
                            startRadius: 0,
                            endRadius: size * 0.6
                        )
                    )
                    .frame(width: size, height: size)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.6),
                                        lumaColor.opacity(0.3)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                
                // Face
                VStack(spacing: size * 0.03) {
                    // Eyes - soft, kind dots
                    HStack(spacing: size * 0.22) {
                        LumaEye(closed: isEyesClosed, size: size)
                        LumaEye(closed: isEyesClosed, size: size)
                    }
                    .offset(y: -size * 0.02)
                    
                    // Smile - gentle curve
                    LumaSmile(amount: smileAmount)
                        .frame(width: size * 0.35, height: size * 0.08)
                }
            }
            .offset(y: floatOffset * 4)
            .rotationEffect(.degrees(mood == .nervous ? nervousTilt : 0))
            
            // Sparkles for proud
            if mood == .proud {
                ForEach(0..<5, id: \.self) { i in
                    Image(systemName: "sparkle")
                        .font(.system(size: size * 0.1, weight: .medium))
                        .foregroundStyle(lumaColor)
                        .opacity(sparkleOpacity)
                        .offset(
                            x: cos(Double(i) * .pi * 0.4) * size * 0.65,
                            y: sin(Double(i) * .pi * 0.4) * size * 0.65
                        )
                }
            }
        }
        .frame(width: size * 1.5, height: size * 1.5)
        .onAppear { startAnimations() }
        .onChange(of: mood) { _, _ in startAnimations() }
    }
    
    private var lumaColor: Color {
        Color(red: 0.65, green: 0.82, blue: 0.92) // Soft sky blue
    }
    
    private func startAnimations() {
        if animateIdle {
            withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                floatOffset = 1
            }
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                glowPulse = 1
            }
        }
        
        if mood == .nervous {
            withAnimation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
                nervousTilt = 3
            }
        } else {
            nervousTilt = 0
        }
        
        if mood == .proud {
            withAnimation(.easeIn(duration: 0.3)) { sparkleOpacity = 0.9 }
        } else {
            sparkleOpacity = 0
        }
    }
}

private struct LumaEye: View {
    let closed: Bool
    let size: CGFloat
    
    var body: some View {
        Group {
            if closed {
                // Closed - peaceful curve
                Capsule()
                    .stroke(Color(red: 0.4, green: 0.55, blue: 0.65), lineWidth: 2.5)
                    .frame(width: size * 0.12, height: size * 0.04)
            } else {
                // Open - soft friendly dot
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color(red: 0.5, green: 0.65, blue: 0.75),
                                Color(red: 0.35, green: 0.5, blue: 0.6)
                            ],
                            center: UnitPoint(x: 0.3, y: 0.3),
                            startRadius: 0,
                            endRadius: size * 0.08
                        )
                    )
                    .frame(width: size * 0.14, height: size * 0.14)
                    .overlay(
                        Circle()
                            .fill(Color.white.opacity(0.5))
                            .frame(width: size * 0.04, height: size * 0.04)
                            .offset(x: size * 0.03, y: -size * 0.02)
                    )
            }
        }
    }
}

private struct LumaSmile: View {
    let amount: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let w = geo.size.width
                let h = geo.size.height
                let curve = h * amount * 1.2
                path.move(to: CGPoint(x: 0, y: h * 0.6))
                path.addQuadCurve(
                    to: CGPoint(x: w, y: h * 0.6),
                    control: CGPoint(x: w * 0.5, y: h * 0.6 + curve)
                )
            }
            .stroke(Color(red: 0.4, green: 0.55, blue: 0.65), lineWidth: 2.5)
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        PipCharacter(mood: .proud, size: 100, animateIdle: false)
        HStack(spacing: 20) {
            PipCharacter(mood: .nervous, size: 60, animateIdle: false)
            PipCharacter(mood: .curious, size: 60, animateIdle: false)
            PipCharacter(mood: .calm, size: 60, animateIdle: false)
            PipCharacter(mood: .sleepy, size: 60, animateIdle: false)
        }
    }
    .padding(40)
    .background(Color(red: 0.92, green: 0.96, blue: 0.98))
}

import SwiftUI

/// Pip the Pinecone - the child's bravery buddy through the Healing Grove
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
    
    private var eyeScale: CGFloat {
        switch mood {
        case .nervous: return 0.7
        case .curious: return 1.2
        case .calm, .proud: return 1.0
        case .sleepy: return 0.3
        }
    }
    
    private var mouthCurve: CGFloat {
        switch mood {
        case .nervous: return -0.3
        case .curious: return 0.2
        case .calm, .proud: return 0.5
        case .sleepy: return 0
        }
    }
    
    private var isEyesClosed: Bool {
        mood == .sleepy
    }
    
    var body: some View {
        ZStack {
            // Pinecone body - layered ovals
            PipBody(size: size)
            
            // Face
            VStack(spacing: -size * 0.05) {
                // Eyes
                HStack(spacing: size * 0.15) {
                    PipEye(scale: eyeScale, isClosed: isEyesClosed)
                    PipEye(scale: eyeScale, isClosed: isEyesClosed)
                }
                .offset(y: -size * 0.08)
                
                // Mouth
                PipMouth(curve: mouthCurve)
                    .frame(width: size * 0.2, height: size * 0.08)
                    .offset(y: size * 0.02)
            }
        }
        .frame(width: size, height: size * 1.1)
    }
}

private struct PipBody: View {
    let size: CGFloat
    
    var body: some View {
        // Cute pinecone creature - warm brown rounded body
        Ellipse()
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.62, green: 0.42, blue: 0.26),
                        Color(red: 0.52, green: 0.35, blue: 0.20)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                Ellipse()
                    .stroke(Color(red: 0.45, green: 0.30, blue: 0.18), lineWidth: 2)
            )
            .frame(width: size * 0.75, height: size)
    }
}

private struct PipEye: View {
    let scale: CGFloat
    let isClosed: Bool
    
    var body: some View {
        Group {
            if isClosed {
                // Closed eye - curved line
                Ellipse()
                    .stroke(Color(red: 0.3, green: 0.2, blue: 0.1), lineWidth: 2)
                    .frame(width: 16 * scale, height: 6)
            } else {
                // Open eye
                Ellipse()
                    .fill(Color(red: 0.95, green: 0.95, blue: 0.98))
                    .overlay(
                        Ellipse()
                            .fill(Color(red: 0.25, green: 0.15, blue: 0.08))
                            .frame(width: 8 * scale, height: 8 * scale)
                    )
                    .frame(width: 18 * scale, height: 18 * scale)
            }
        }
    }
}

private struct PipMouth: View {
    let curve: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let w = geo.size.width
                let h = geo.size.height
                path.move(to: CGPoint(x: 0, y: h * 0.5))
                path.addQuadCurve(
                    to: CGPoint(x: w, y: h * 0.5),
                    control: CGPoint(x: w * 0.5, y: h * (0.5 - curve))
                )
            }
            .stroke(Color(red: 0.35, green: 0.22, blue: 0.12), lineWidth: 2)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack {
            PipCharacter(mood: .nervous, size: 80)
            PipCharacter(mood: .curious, size: 80)
        }
        HStack {
            PipCharacter(mood: .calm, size: 80)
            PipCharacter(mood: .proud, size: 80)
            PipCharacter(mood: .sleepy, size: 80)
        }
    }
    .padding()
}

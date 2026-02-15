import SwiftUI

/// A friendly Guardian (nurse) character for the Check-In scene
struct GuardianCharacter: View {
    var size: CGFloat = 100
    @State private var waveOffset: Double = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Friendly face
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.98, green: 0.94, blue: 0.88),
                                Color(red: 0.95, green: 0.90, blue: 0.82)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size * 0.5, height: size * 0.5)
                    .overlay(
                        Circle()
                            .stroke(Color(red: 0.9, green: 0.85, blue: 0.78), lineWidth: 1)
                    )
                
                // Kind eyes
                HStack(spacing: size * 0.12) {
                    GuardianEye()
                    GuardianEye()
                }
                .offset(y: -size * 0.04)
                
                // Warm smile
                Capsule()
                    .fill(Color(red: 0.6, green: 0.45, blue: 0.4).opacity(0.6))
                    .frame(width: size * 0.12, height: size * 0.03)
                    .offset(y: size * 0.06)
            }
            
            // Scrubs - soft teal top
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.45, green: 0.78, blue: 0.88),
                                Color(red: 0.38, green: 0.68, blue: 0.78)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: size * 0.6, height: size * 0.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 0.5, green: 0.82, blue: 0.92), lineWidth: 1)
                    )
                
                // Collar
                VShape()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: size * 0.25, height: size * 0.08)
                    .offset(y: 4)
                
                // Name tag + thermometer
                HStack(spacing: 4) {
                    Image(systemName: "thermometer.medium")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(red: 0.4, green: 0.7, blue: 0.8))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .frame(width: size * 0.15, height: size * 0.07)
                        .overlay(
                            Text("Hi!")
                                .font(.system(size: 9, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.35, green: 0.65, blue: 0.75))
                        )
                }
                .offset(y: size * 0.1)
            }
            .offset(y: -size * 0.05)
            
            // Clipboard
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(red: 0.97, green: 0.95, blue: 0.92))
                    .frame(width: size * 0.28, height: size * 0.32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(red: 0.88, green: 0.84, blue: 0.8), lineWidth: 1)
                    )
                VStack(spacing: 3) {
                    ForEach(0..<3, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 1)
                            .fill(Color(red: 0.75, green: 0.7, blue: 0.65).opacity(0.35))
                            .frame(height: 3)
                    }
                }
                .frame(width: size * 0.15)
            }
            .offset(x: size * 0.28, y: -size * 0.18)
            .rotationEffect(.degrees(waveOffset))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                waveOffset = 5
            }
        }
    }
}

private struct GuardianEye: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Ellipse()
                .fill(Color(red: 0.4, green: 0.55, blue: 0.6))
                .frame(width: 8, height: 10)
            Circle()
                .fill(Color.white.opacity(0.6))
                .frame(width: 3, height: 3)
                .offset(x: 2, y: 2)
        }
    }
}

private struct VShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        p.addLine(to: CGPoint(x: rect.width, y: 0))
        p.closeSubpath()
        return p
    }
}

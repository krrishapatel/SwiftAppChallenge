import SwiftUI

/// Tap to discover surprises — butterfly, blooming flowers (playful exploration)
struct SecretGardenView: View {
    @Binding var discoveredButterfly: Bool
    @Binding var discoveredFlowers: Bool
    
    @State private var butterflyOffset: CGSize = .zero
    @State private var flowerScale: CGFloat = 0.8
    @State private var hintOpacity: Double = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.7, green: 0.9, blue: 0.8).opacity(0.6),
                            Color(red: 0.65, green: 0.85, blue: 0.75).opacity(0.5)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 140)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.white.opacity(0.5), lineWidth: 1)
                )
            
            HStack(spacing: 16) {
                // Reception desk
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(red: 0.55, green: 0.4, blue: 0.28))
                    .frame(width: 50, height: 32)
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.cyan.opacity(0.5), Color.blue.opacity(0.4)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 44, height: 44)
                
                // Tappable flowers
                Button {
                    discoverFlowers()
                } label: {
                    ZStack {
                        Text(discoveredFlowers ? "🌸🌼🌷" : "🌱")
                            .font(.system(size: discoveredFlowers ? 26 : 22))
                            .scaleEffect(flowerScale)
                    }
                }
                .buttonStyle(.plain)
                
                Text("🧸")
                    .font(.system(size: 28))
                Text("📚")
                    .font(.system(size: 28))
            }
            
            // Butterfly - appears when tapping garden
            if discoveredButterfly {
                Text("🦋")
                    .font(.system(size: 36))
                    .offset(butterflyOffset)
            }
        }
        .padding(.horizontal, 24)
        .onTapGesture {
            if !discoveredButterfly {
                discoverButterfly()
            }
        }
        .overlay(alignment: .bottom) {
            if hintOpacity > 0 {
                Text("Tap around to find surprises! 👆")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(AppColor.textSecondary)
                    .opacity(hintOpacity)
                    .padding(.bottom, -20)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.5).delay(2)) {
                hintOpacity = 0.7
            }
        }
    }
    
    private func discoverButterfly() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
        discoveredButterfly = true
        butterflyOffset = CGSize(width: -30, height: -40)
        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
            butterflyOffset = CGSize(width: 35, height: -25)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                butterflyOffset = CGSize(width: 40, height: -30)
            }
        }
    }
    
    private func discoverFlowers() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
        discoveredFlowers = true
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            flowerScale = 1.2
        }
    }
}

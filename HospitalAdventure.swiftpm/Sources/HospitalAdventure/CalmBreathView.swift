import SwiftUI

/// Guided breathing with Luma - ResQ-style calming moment before Courage Vines
struct CalmBreathView: View {
    @Binding var isComplete: Bool
    @State private var breathScale: CGFloat = 1
    @State private var breathCount: Int = 0
    @State private var ringScale: CGFloat = 0.8
    let totalBreaths = 3
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Take a big breath with Luma! 🌬️")
                .font(AppFont.headline)
                .foregroundStyle(AppColor.textPrimary)
                .multilineTextAlignment(.center)
            
            ZStack {
                Circle()
                    .stroke(Color(red: 0.7, green: 0.88, blue: 0.85), lineWidth: 4)
                    .frame(width: 140, height: 140)
                    .scaleEffect(ringScale)
                    .opacity(0.6)
                
                PipCharacter(mood: .calm, size: 100)
                    .scaleEffect(breathScale)
                
                if breathCount == totalBreaths {
                    MiniCelebrationView()
                        .offset(y: -60)
                }
            }
            .frame(height: 160)
            
            Text(breathCount < totalBreaths ? "Breathe in... and out..." : "You did it! So calm!")
                .font(AppFont.caption)
                .foregroundStyle(AppColor.textSecondary)
            
            HStack(spacing: 10) {
                ForEach(0..<totalBreaths, id: \.self) { i in
                    Circle()
                        .fill(i < breathCount ? AppColor.teal : Color(red: 0.85, green: 0.9, blue: 0.88))
                        .frame(width: 14, height: 14)
                        .scaleEffect(i < breathCount ? 1.2 : 1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: breathCount)
                }
            }
            
            Button("I'm ready!") {
                withAnimation { isComplete = true }
            }
            .font(AppFont.caption)
            .foregroundStyle(AppColor.teal)
        }
        .padding(24)
        .onAppear { runBreathCycle() }
    }
    
    private func runBreathCycle() {
        for i in 0..<totalBreaths {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 2.4) {
                withAnimation(.easeInOut(duration: 1)) {
                    breathScale = 1.15
                    ringScale = 1.25
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1)) {
                        breathScale = 1
                        ringScale = 1.1
                        breathCount = i + 1
                    }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(totalBreaths) * 2.4 + 0.8) {
            withAnimation { isComplete = true }
        }
    }
}

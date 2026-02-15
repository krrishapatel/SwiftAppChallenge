import SwiftUI

struct AdventureButton: View {
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    
    enum ButtonStyle {
        case primary   // Compact, pill-shaped
        case secondary // Even smaller for secondary actions
    }
    
    var body: some View {
        Button(action: {
            #if os(iOS)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            #endif
            action()
        }) {
            Text(title)
                .font(style == .primary ? AppFont.headline : AppFont.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.horizontal, style == .primary ? 28 : 20)
                .padding(.vertical, style == .primary ? 14 : 10)
                .background(
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.45, green: 0.72, blue: 0.58),
                                    Color(red: 0.38, green: 0.62, blue: 0.50)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: Color(red: 0.35, green: 0.6, blue: 0.5).opacity(0.35), radius: 6, y: 3)
                )
        }
        .buttonStyle(PlainScaleStyle())
    }
}

struct PlainScaleStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

struct PipSpeechBubble: View {
    let text: String
    
    @State private var appeared = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    var body: some View {
        Text(text)
            .accessibilityLabel("Luma says: \(text)")
            .font(AppFont.body)
            .multilineTextAlignment(.center)
            .foregroundStyle(AppColor.textPrimary)
            .lineSpacing(4)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.92))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [.white.opacity(0.8), .white.opacity(0.3)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
            )
            .scaleEffect(appeared ? 1 : (reduceMotion ? 1 : 0.9))
            .opacity(appeared ? 1 : (reduceMotion ? 1 : 0))
            .onAppear {
                if reduceMotion {
                    appeared = true
                } else {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        appeared = true
                    }
                }
            }
    }
}

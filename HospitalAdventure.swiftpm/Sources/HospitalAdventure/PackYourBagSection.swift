import SwiftUI

/// Tap-to-check packing checklist - empowers child to feel prepared
struct PackYourBagSection: View {
    @EnvironmentObject var state: AdventureState
    
    private let packItems = [
        ("Comfy clothes", "👕"),
        ("Toothbrush", "🪥"),
        ("Favorite toy", "🧸"),
        ("Snacks", "🍎")
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Pack your adventure bag! 🎒")
                .font(AppFont.headline)
                .foregroundStyle(AppColor.textPrimary)
            
            VStack(spacing: 8) {
                ForEach(packItems, id: \.0) { item, emoji in
                    Button {
                        state.togglePackedItem(item)
                        #if os(iOS)
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        #endif
                    } label: {
                        HStack(spacing: 12) {
                            PackItemCheckView(checked: state.packedItems.contains(item))
                            Text(emoji)
                                .font(.system(size: 20))
                            Text(item)
                                .font(AppFont.body)
                                .foregroundStyle(AppColor.textPrimary)
                            Spacer()
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(state.packedItems.contains(item) ? Color(red: 0.9, green: 0.97, blue: 0.94) : Color.white.opacity(0.9))
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            if state.packedItems.count == packItems.count {
                ZStack {
                    MiniCelebrationView()
                        .offset(y: -25)
                    HStack(spacing: 6) {
                        Text("All packed!")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColor.teal)
                        Text("🎒✨")
                            .font(.system(size: 16))
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
    }
}

private struct PackItemCheckView: View {
    let checked: Bool
    @State private var popScale: CGFloat = 1
    var body: some View {
        Image(systemName: checked ? "checkmark.circle.fill" : "circle")
            .font(.system(size: 22))
            .foregroundStyle(checked ? AppColor.teal : Color(red: 0.7, green: 0.78, blue: 0.75))
            .scaleEffect(popScale)
            .onChange(of: checked) { _, isChecked in
                if isChecked {
                    popScale = 1.3
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) { popScale = 1 }
                }
            }
    }
}


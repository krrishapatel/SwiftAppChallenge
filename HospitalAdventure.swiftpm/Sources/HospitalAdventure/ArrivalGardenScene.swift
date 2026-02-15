import SwiftUI

struct ArrivalGardenScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var worryBubblesPopped = false
    @State private var discoveredButterfly = false
    @State private var discoveredFlowers = false
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("The Arrival Garden")
                    .font(AppFont.title)
                    .foregroundStyle(Color(red: 0.2, green: 0.42, blue: 0.48))
                
                TappableLumaView(mood: .curious, size: 100)
                
                PipSpeechBubble(
                    text: "\(displayName), this is where you'll arrive with Mom or Dad. Look — it's like a garden!"
                )
                
                LumasBraveTipView(scene: .arrivalGarden)
                    .padding(.horizontal, 20)
                
                // Garden - welcoming scene with secret discoveries
                SecretGardenView(
                    discoveredButterfly: $discoveredButterfly,
                    discoveredFlowers: $discoveredFlowers
                )
                
                Text("What will you bring?")
                    .font(AppFont.headline)
                    .foregroundStyle(AppColor.textPrimary)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(ComfortItem.allCases, id: \.self) { item in
                        Button {
                            state.chosenComfortItem = item
                        } label: {
                            VStack(spacing: 6) {
                                Text(item.emoji)
                                    .font(.system(size: 28))
                                Text(item.rawValue)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(state.chosenComfortItem == item ? .white : AppColor.textPrimary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(state.chosenComfortItem == item ? Color(red: 0.42, green: 0.68, blue: 0.55) : Color.white.opacity(0.85))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .strokeBorder(state.chosenComfortItem == item ? Color.clear : Color.white.opacity(0.6), lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                
                PipSpeechBubble(text: state.chosenComfortItem.buddyResponse)
                
                PackYourBagSection()
                
                WorryBubblesView(allPopped: $worryBubblesPopped, onPop: {})
                
                PipSpeechBubble(
                    text: worryBubblesPopped
                        ? "Worries float away when we notice them. You're doing great, \(displayName)! 💙"
                        : "I'm bringing you! You're my best buddy!"
                )
                
                AdventureButton(title: "Continue") { state.advanceToNextScene() }
                    .padding(.bottom, 40)
            }
            .padding(.top, 24)
        }
    }
}

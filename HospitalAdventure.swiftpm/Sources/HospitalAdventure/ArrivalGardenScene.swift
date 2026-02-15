import SwiftUI

struct ArrivalGardenScene: View {
    @EnvironmentObject var state: AdventureState
    
    var displayName: String {
        state.childName.isEmpty ? "Brave One" : state.childName
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("The Arrival Garden")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                
                PipCharacter(mood: .curious, size: 100)
                
                PipSpeechBubble(
                    text: "\(displayName), this is where you'll arrive with Mom or Dad. Look — it's like a garden!"
                )
                
                // Garden illustration - simple shapes
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.6, green: 0.85, blue: 0.65).opacity(0.6))
                        .frame(height: 140)
                    
                    HStack(spacing: 24) {
                        // Bench
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 0.5, green: 0.35, blue: 0.2))
                            .frame(width: 60, height: 40)
                        
                        // Fish tank (circle)
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 50, height: 50)
                        
                        // Toys
                        Text("🧸")
                            .font(.title)
                        Text("📚")
                            .font(.title)
                    }
                }
                .padding(.horizontal, 20)
                
                Text("What will you bring?")
                    .font(.headline)
                    .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.3))
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(ComfortItem.allCases, id: \.self) { item in
                        Button {
                            state.chosenComfortItem = item
                        } label: {
                            VStack(spacing: 8) {
                                Text(item.emoji)
                                    .font(.system(size: 36))
                                Text(item.rawValue)
                                    .font(.caption)
                                    .foregroundColor(state.chosenComfortItem == item ? .white : Color(red: 0.25, green: 0.35, blue: 0.3))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(state.chosenComfortItem == item ? Color(red: 0.35, green: 0.65, blue: 0.45) : Color.white.opacity(0.7))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 32)
                
                PipSpeechBubble(text: state.chosenComfortItem.pipResponse)
                
                PipSpeechBubble(text: "I'm bringing you! You're my best buddy!")
                
                AdventureButton(title: "Continue") {
                    state.advanceToNextScene()
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
            .padding(.top, 24)
        }
    }
}

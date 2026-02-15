import SwiftUI

struct WelcomeScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var nameInput: String = ""
    @State private var showNameField: Bool = false
    @FocusState private var isNameFocused: Bool
    
    var body: some View {
        ScrollView {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Hospital Adventure")
                .font(AppFont.largeTitle)
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.2, green: 0.45, blue: 0.5),
                            Color(red: 0.15, green: 0.35, blue: 0.4)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            TappableLumaView(mood: .nervous, size: 130)
                .padding(8)
            
            if showNameField {
                VStack(spacing: 18) {
                    Text("What kind of adventure?")
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textSecondary)
                    
                    HStack(spacing: 10) {
                        ForEach(ProcedureType.allCases, id: \.self) { type in
                            Button {
                                state.procedureType = type
                            } label: {
                                VStack(spacing: 4) {
                                    Text(type.emoji)
                                        .font(.system(size: 24))
                                    Text(type.rawValue)
                                        .font(.system(size: 11, weight: .medium, design: .rounded))
                                        .foregroundStyle(state.procedureType == type ? .white : AppColor.textPrimary)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(state.procedureType == type ? AppColor.teal : Color.white.opacity(0.9))
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    Text("What's your name, adventurer?")
                        .font(AppFont.headline)
                        .foregroundStyle(Color(red: 0.3, green: 0.42, blue: 0.48))
                    
                    TextField("Type your name here", text: $nameInput)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .focused($isNameFocused)
                        .submitLabel(.done)
                        .textFieldStyle(.plain)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 0.5, green: 0.75, blue: 0.7).opacity(0.5), lineWidth: 2)
                                )
                        )
                        .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 36))
                }
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.9).combined(with: .opacity),
                    removal: .opacity
                ))
            }
            
            if showNameField {
                LumasBraveTipView(scene: .welcome)
                    .padding(.horizontal, 24)
            }
            
            PipSpeechBubble(
                text: showNameField
                    ? "I'm Luma! I'm a little nervous about the Healing Grove. Will you come with me?"
                    : "Hey! You're going to the Healing Grove soon. Want to explore it together first?"
            )
            
            Spacer()
            
            AdventureButton(title: showNameField ? "Yes! I'll come with you!" : "Let's explore!") {
                if showNameField {
                    state.childName = nameInput.trimmingCharacters(in: .whitespaces).isEmpty ? "Brave One" : nameInput
                    state.advanceToNextScene()
                } else {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        showNameField = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            isNameFocused = true
                        }
                    }
                }
            }
            .padding(.bottom, 40)
        }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

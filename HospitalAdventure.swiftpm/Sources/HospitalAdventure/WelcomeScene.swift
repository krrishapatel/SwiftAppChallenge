import SwiftUI

struct WelcomeScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var nameInput: String = ""
    @State private var showNameField: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Hospital Adventure")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            PipCharacter(mood: .nervous, size: 140)
                .padding(.vertical, 8)
            
            if showNameField {
                VStack(spacing: 12) {
                    Text("What's your name?")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.3))
                    
                    TextField("Type your name", text: $nameInput)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .onChange(of: nameInput) { _, newValue in
                            state.childName = newValue
                        }
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
            
            PipSpeechBubble(
                text: showNameField
                    ? "I'm Pip! I'm a little nervous about the Healing Grove. Will you come with me?"
                    : "Hey! You're going to the Healing Grove soon. Want to explore it together first?"
            )
            
            Spacer()
            
            AdventureButton(
                title: showNameField ? "Yes! I'll come with you!" : "Let's explore!"
            ) {
                if showNameField {
                    if nameInput.isEmpty {
                        state.childName = "Brave One"
                    } else {
                        state.childName = nameInput
                    }
                    state.advanceToNextScene()
                } else {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showNameField = true
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
    }
}

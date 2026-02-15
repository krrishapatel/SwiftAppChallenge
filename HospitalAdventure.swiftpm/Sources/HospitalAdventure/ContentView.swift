import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: AdventureState
    @State private var floatingOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Healing Grove - fresh mint & sky gradient
            LinearGradient(
                colors: [
                    Color(red: 0.88, green: 0.96, blue: 0.94),
                    Color(red: 0.82, green: 0.94, blue: 0.92),
                    Color(red: 0.75, green: 0.90, blue: 0.88)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Soft ambient orbs
            GeometryReader { geo in
                ForEach(0..<8, id: \.self) { i in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color(red: 0.65, green: 0.88, blue: 0.92).opacity(0.25),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 70
                            )
                        )
                        .frame(width: 140, height: 140)
                        .offset(
                            x: CGFloat([0.05, 0.75, 0.35, 0.9, 0.55, 0.2, 0.65, 0.4][i]) * geo.size.width - 70,
                            y: CGFloat([0.1, 0.35, 0.7, 0.2, 0.85, 0.5, 0.25, 0.6][i]) * geo.size.height - 70 + sin(floatingOffset + Double(i) * 0.7) * 6
                        )
                        .blur(radius: 25)
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    AdventureProgressView()
                        .opacity(state.currentScene == .welcome ? 0 : 1)
                    
                    // Star celebration when earning a new bravery star
                    if state.lastStarCelebration > 0 {
                        StarCelebrationOverlay(starIndex: state.lastStarCelebration)
                            .offset(x: -60, y: 50)
                            .id(state.lastStarCelebration)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                    state.lastStarCelebration = 0
                                }
                            }
                    }
                }
                
                Group {
                    switch state.currentScene {
                case .welcome:
                    WelcomeScene()
                case .arrivalGarden:
                    ArrivalGardenScene()
                case .checkInNest:
                    CheckInNestScene()
                case .changingRoom:
                    ChangingRoomScene()
                case .courageVines:
                    CourageVinesScene()
                case .restChamber:
                    RestChamberScene()
                case .cozyNest:
                    CozyNestScene()
                case .braveryCeremony:
                    BraveryCeremonyScene()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .id(state.currentScene.rawValue)
            .transition(.asymmetric(
                insertion: .opacity.combined(with: .scale(scale: 0.97)).combined(with: .move(edge: .trailing)),
                removal: .opacity.combined(with: .scale(scale: 0.98))
            ))
        }
        .preferredColorScheme(.light)
        .tint(AppColor.teal)
        .onAppear {
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                floatingOffset = .pi * 2
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AdventureState())
}

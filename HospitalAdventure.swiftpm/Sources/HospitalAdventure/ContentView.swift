import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: AdventureState
    
    var body: some View {
        ZStack {
            // Healing Grove gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.85, green: 0.95, blue: 0.88),
                    Color(red: 0.75, green: 0.90, blue: 0.82)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
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
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
        .environmentObject(AdventureState())
}

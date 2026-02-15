import SwiftUI

@main
struct HospitalAdventureApp: App {
    @StateObject private var adventureState = AdventureState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(adventureState)
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Hospital Adventure – Prepare for your Healing Grove visit with Luma")
        }
    }
}

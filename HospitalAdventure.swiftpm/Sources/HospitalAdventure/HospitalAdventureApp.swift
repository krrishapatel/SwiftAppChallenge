import SwiftUI

@main
struct HospitalAdventureApp: App {
    @StateObject private var adventureState = AdventureState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(adventureState)
        }
    }
}

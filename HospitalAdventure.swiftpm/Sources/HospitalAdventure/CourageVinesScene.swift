import SwiftUI

struct CourageVinesScene: View {
    @EnvironmentObject var state: AdventureState
    @State private var calmBreathDone: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            if !calmBreathDone {
                CalmBreathView(isComplete: $calmBreathDone)
            } else {
                CourageVinesMainView()
                    .environmentObject(state)
            }
        }
        .padding(.top, 16)
    }
}

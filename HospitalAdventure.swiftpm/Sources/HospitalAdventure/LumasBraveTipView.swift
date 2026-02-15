import SwiftUI

/// Luma's rotating brave tips — reassuring, age-appropriate wisdom
struct LumasBraveTipView: View {
    let scene: AdventureScene
    
    private var tip: String {
        switch scene {
        case .welcome: return "Luma says: Every brave adventurer started as nervous — you're not alone! 💙"
        case .arrivalGarden: return "Luma says: It's okay to hold a grown-up's hand — that's what they're there for!"
        case .checkInNest: return "Luma says: Guardians love when we tell them how we feel. Use your words! 🗣️"
        case .changingRoom: return "Luma says: Pajamas might feel funny at first — that's totally normal!"
        case .courageVines: return "Luma says: Taking deep breaths helps our bodies feel calmer. Try it! 🌬️"
        case .restChamber: return "Luma says: Sleep is like a cozy pause — you'll wake up when you're ready."
        case .cozyNest: return "Luma says: Waking up in a new place can feel strange — a grown-up will be right there! ☀️"
        case .braveryCeremony: return "Luma says: You did something hard today. That makes you brave! 🌟"
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Text("💡")
                .font(.system(size: 14))
            Text(tip)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.4, green: 0.52, blue: 0.55))
                .lineSpacing(2)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.92, green: 0.97, blue: 0.95))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(red: 0.7, green: 0.88, blue: 0.82), lineWidth: 1)
        )
    }
}

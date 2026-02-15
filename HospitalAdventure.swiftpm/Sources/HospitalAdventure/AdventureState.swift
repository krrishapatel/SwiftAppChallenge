import SwiftUI

/// Shared state across the adventure - child's name, current scene, choices
final class AdventureState: ObservableObject {
    @Published var childName: String = ""
    @Published var currentScene: AdventureScene = .welcome
    @Published var chosenComfortItem: ComfortItem = .teddy
    @Published var hasCompletedAdventure: Bool = false
    
    func advanceToNextScene() {
        guard let next = currentScene.next else {
            hasCompletedAdventure = true
            return
        }
        withAnimation(.easeInOut(duration: 0.4)) {
            currentScene = next
        }
    }
    
    func resetAdventure() {
        withAnimation {
            currentScene = .welcome
            hasCompletedAdventure = false
        }
    }
}

enum AdventureScene: Int, CaseIterable {
    case welcome = 0
    case arrivalGarden
    case checkInNest
    case changingRoom
    case courageVines
    case restChamber
    case cozyNest
    case braveryCeremony
    
    var next: AdventureScene? {
        AdventureScene(rawValue: rawValue + 1)
    }
    
    var isLast: Bool {
        self == .braveryCeremony
    }
}

enum ComfortItem: String, CaseIterable {
    case teddy = "Teddy"
    case book = "Book"
    case drawing = "Drawing"
    case nothing = "Nothing"
    
    var emoji: String {
        switch self {
        case .teddy: return "🧸"
        case .book: return "📖"
        case .drawing: return "✏️"
        case .nothing: return "✨"
        }
    }
    
    var pipResponse: String {
        switch self {
        case .teddy: return "A teddy! The best snuggle buddy!"
        case .book: return "A book! Adventures before the adventure!"
        case .drawing: return "Your drawings! You can show the Guardians!"
        case .nothing: return "Just you! That's all we need!"
        }
    }
}

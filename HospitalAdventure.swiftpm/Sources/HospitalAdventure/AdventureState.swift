import SwiftUI

/// Procedure type for personalized dialogue
enum ProcedureType: String, CaseIterable {
    case general = "General"
    case ears = "Ears"
    case tummy = "Tummy"
    
    var emoji: String {
        switch self {
        case .general: return "✨"
        case .ears: return "👂"
        case .tummy: return "💚"
        }
    }
    
    var customHint: String? {
        switch self {
        case .ears: return "They might look in your ears — it tickles!"
        case .tummy: return "They might gently check your tummy — super quick!"
        default: return nil
        }
    }
}

/// Shared state across the adventure
final class AdventureState: ObservableObject {
    @Published var childName: String = ""
    @Published var currentScene: AdventureScene = .welcome
    @Published var chosenComfortItem: ComfortItem = .teddy
    @Published var procedureType: ProcedureType = .general
    @Published var hasCompletedAdventure: Bool = false
    @Published var collectedStars: Set<Int> = []
    @Published var packedItems: Set<String> = []
    @Published var lastStarCelebration: Int = 0
    
    var starCount: Int { collectedStars.count }
    
    func advanceToNextScene() {
        // Collect star for completing current scene (except welcome)
        if currentScene != .welcome {
            collectedStars.insert(currentScene.rawValue)
            lastStarCelebration = currentScene.rawValue
        }
        
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
            collectedStars = []
            packedItems = []
        }
    }
    
    func togglePackedItem(_ item: String) {
        if packedItems.contains(item) {
            packedItems.remove(item)
        } else {
            packedItems.insert(item)
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
    
    var shortName: String {
        switch self {
        case .welcome: return "Start"
        case .arrivalGarden: return "Garden"
        case .checkInNest: return "Check-in"
        case .changingRoom: return "Pajamas"
        case .courageVines: return "Vines"
        case .restChamber: return "Nap"
        case .cozyNest: return "Wake"
        case .braveryCeremony: return "Done!"
        }
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
    
    var buddyResponse: String {
        switch self {
        case .teddy: return "A teddy! The best snuggle buddy!"
        case .book: return "A book! Adventures before the adventure!"
        case .drawing: return "Your drawings! You can show the Guardians!"
        case .nothing: return "Just you! That's all we need!"
        }
    }
}

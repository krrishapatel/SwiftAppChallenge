import SwiftUI

/// Typography for a friendly, professional, child-appropriate experience
/// Inspired by award-winning apps: clear hierarchy, playful but readable
enum AppFont {
    static let largeTitle = Font.system(size: 28, weight: .bold, design: .rounded)
    static let title = Font.system(size: 24, weight: .bold, design: .rounded)
    static let headline = Font.system(size: 19, weight: .semibold, design: .rounded)
    static let body = Font.system(size: 17, weight: .regular, design: .rounded)
    static let callout = Font.system(size: 16, weight: .medium, design: .rounded)
    static let caption = Font.system(size: 15, weight: .medium, design: .rounded)
}

enum AppColor {
    static let teal = Color(red: 0.35, green: 0.6, blue: 0.65)
    static let tealLight = Color(red: 0.5, green: 0.75, blue: 0.7)
    static let textPrimary = Color(red: 0.25, green: 0.32, blue: 0.38)
    static let textSecondary = Color(red: 0.4, green: 0.55, blue: 0.58)
}

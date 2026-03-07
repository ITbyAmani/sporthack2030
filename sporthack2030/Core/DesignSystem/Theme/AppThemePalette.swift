import SwiftUI

struct ThemeColors {
    let background: Color
    let card: Color
    let primaryText: Color
    let interactive: Color
    let preventionAlert: Color
    let cardBorder: Color
}

enum AppThemePalette: String, CaseIterable, Identifiable {
    case techMinimalist
    case eliteSport
    case kineticEnergy

    static let storageKey = "selectedThemePalette"
    static let defaultPalette: AppThemePalette = .techMinimalist

    var id: String { rawValue }

    var title: String {
        switch self {
        case .techMinimalist:
            return "النقاء الأزرق"
        case .eliteSport:
            return "الهوية الرياضية الفخمة"
        case .kineticEnergy:
            return "طاقة الأداء"
        }
    }

    var subtitle: String {
        switch self {
        case .techMinimalist:
            return "طابع تقني دقيق"
        case .eliteSport:
            return "هوية احترافية فخمة"
        case .kineticEnergy:
            return "تنبيهات حيوية قوية"
        }
    }

    func colors(for colorScheme: ColorScheme) -> ThemeColors {
        colorScheme == .dark ? darkColors : lightColors
    }

    private var lightColors: ThemeColors {
        switch self {
        case .techMinimalist:
            return ThemeColors(
                background: Color(hex: "#F9FAFB"),
                card: Color(hex: "#FFFFFF"),
                primaryText: Color(hex: "#111827"),
                interactive: Color(hex: "#3B82F6"),
                preventionAlert: Color(hex: "#EF4444"),
                cardBorder: Color(hex: "#E5E7EB")
            )
        case .eliteSport:
            return ThemeColors(
                background: Color(hex: "#F3F4F6"),
                card: Color(hex: "#FFFFFF"),
                primaryText: Color(hex: "#0F172A"),
                interactive: Color(hex: "#10B981"),
                preventionAlert: Color(hex: "#EF4444"),
                cardBorder: Color(hex: "#D1D5DB")
            )
        case .kineticEnergy:
            return ThemeColors(
                background: Color(hex: "#FAFAFA"),
                card: Color(hex: "#FFFFFF"),
                primaryText: Color(hex: "#262626"),
                interactive: Color(hex: "#7C3AED"),
                preventionAlert: Color(hex: "#EF4444"),
                cardBorder: Color(hex: "#E5E5E5")
            )
        }
    }

    private var darkColors: ThemeColors {
        switch self {
        case .techMinimalist:
            return ThemeColors(
                background: Color(hex: "#000000"),
                card: Color(hex: "#1C1C1E"),
                primaryText: Color(hex: "#FFFFFF"),
                interactive: Color(hex: "#60A5FA"),
                preventionAlert: Color(hex: "#F87171"),
                cardBorder: Color(hex: "#2A2A2E")
            )
        case .eliteSport:
            return ThemeColors(
                background: Color(hex: "#0F172A"),
                card: Color(hex: "#1E293B"),
                primaryText: Color(hex: "#F8FAFC"),
                interactive: Color(hex: "#34D399"),
                preventionAlert: Color(hex: "#F87171"),
                cardBorder: Color(hex: "#334155")
            )
        case .kineticEnergy:
            return ThemeColors(
                background: Color(hex: "#171717"),
                card: Color(hex: "#262626"),
                primaryText: Color(hex: "#EDEDED"),
                interactive: Color(hex: "#A78BFA"),
                preventionAlert: Color(hex: "#F87171"),
                cardBorder: Color(hex: "#3F3F46")
            )
        }
    }
}

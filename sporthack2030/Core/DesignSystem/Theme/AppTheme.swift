import SwiftUI

enum AppTheme {
    static func selectedPalette() -> AppThemePalette {
        let rawValue = UserDefaults.standard.string(forKey: AppThemePalette.storageKey)
        return AppThemePalette(rawValue: rawValue ?? "") ?? AppThemePalette.defaultPalette
    }

    static func background(for colorScheme: ColorScheme) -> Color {
        selectedPalette().colors(for: colorScheme).background
    }

    static func card(for colorScheme: ColorScheme) -> Color {
        selectedPalette().colors(for: colorScheme).card
    }

    static func primaryText(for colorScheme: ColorScheme) -> Color {
        selectedPalette().colors(for: colorScheme).primaryText
    }

    static func interactive(for colorScheme: ColorScheme) -> Color {
        selectedPalette().colors(for: colorScheme).interactive
    }

    static func preventionAlert(for colorScheme: ColorScheme) -> Color {
        selectedPalette().colors(for: colorScheme).preventionAlert
    }

    static func cardBorder(for colorScheme: ColorScheme) -> Color {
        selectedPalette().colors(for: colorScheme).cardBorder
    }
}

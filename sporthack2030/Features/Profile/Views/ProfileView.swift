import SwiftUI

struct ProfileView: View {
    @AppStorage(AppThemePalette.storageKey) private var selectedPaletteRaw = AppThemePalette.defaultPalette.rawValue
    @Environment(\.colorScheme) private var colorScheme

    private var selectedPalette: AppThemePalette {
        AppThemePalette(rawValue: selectedPaletteRaw) ?? AppThemePalette.defaultPalette
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    themeSection
                    ForEach(AppThemePalette.allCases) { palette in
                        paletteRow(for: palette)
                    }
                }
                .padding()
            }
            .background(AppTheme.background(for: colorScheme))
            .navigationTitle("الملف الشخصي")
        }
    }

    private var themeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("تغيير الوان التطبيق")
                .font(.appFont(.medium, size: 18))
                .foregroundStyle(AppTheme.primaryText(for: colorScheme))

            Text("اختر مجموعة الألوان المناسبة لك، ويمكنك التبديل بينها في أي وقت.")
                .font(.appFont(.regular, size: 14))
                .foregroundStyle(AppTheme.primaryText(for: colorScheme).opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(AppTheme.card(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(AppTheme.cardBorder(for: colorScheme), lineWidth: 1)
        )
    }

    private func paletteRow(for palette: AppThemePalette) -> some View {
        let isSelected = palette == selectedPalette
        let previewColors = palette.colors(for: colorScheme)

        return Button {
            selectedPaletteRaw = palette.rawValue
        } label: {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(palette.title)
                        .font(.appFont(.medium, size: 15))
                        .foregroundStyle(AppTheme.primaryText(for: colorScheme))
                    Text(palette.subtitle)
                        .font(.appFont(.regular, size: 13))
                        .foregroundStyle(AppTheme.primaryText(for: colorScheme).opacity(0.7))
                }

                Spacer()

                HStack(spacing: 6) {
                    Circle().fill(previewColors.background).frame(width: 14, height: 14)
                    Circle().fill(previewColors.card).frame(width: 14, height: 14)
                    Circle().fill(previewColors.interactive).frame(width: 14, height: 14)
                }

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(isSelected ? AppTheme.interactive(for: colorScheme) : AppTheme.cardBorder(for: colorScheme))
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppTheme.card(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(
                        isSelected ? AppTheme.interactive(for: colorScheme) : AppTheme.cardBorder(for: colorScheme),
                        lineWidth: isSelected ? 1.2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileView()
}

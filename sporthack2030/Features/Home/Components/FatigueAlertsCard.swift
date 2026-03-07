import SwiftUI

struct FatigueAlertsCard: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        CardContainer(
            title: "تنبيهات السلامة",
            goal: "رصد مؤشرات التعب وتصحيح الحركات الخاطئة لحظياً."
        ) {
            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    Text("تنبيه السلامة نشط")
                        .font(.appFont(.medium, size: 14))
                        .foregroundStyle(AppTheme.preventionAlert(for: colorScheme))
                    Spacer()
                }
                .padding(10)
                .background(AppTheme.preventionAlert(for: colorScheme).opacity(colorScheme == .dark ? 0.18 : 0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                HStack(spacing: 10) {
                    MetricTile(
                        title: "حالة الإجهاد",
                        value: "مثالي",
                        tint: AppTheme.preventionAlert(for: colorScheme)
                    )
                    MetricTile(
                        title: "تنبيه تقني",
                        value: "ميلان في الجذع",
                        tint: AppTheme.preventionAlert(for: colorScheme)
                    )
                }

                MetricTile(
                    title: "نصيحة فورية",
                    value: "حافظ على استقامة الظهر أثناء المراوغة",
                    tint: AppTheme.preventionAlert(for: colorScheme)
                )
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(AppTheme.preventionAlert(for: colorScheme).opacity(colorScheme == .dark ? 0.35 : 0.25), lineWidth: 1)
        )
    }
}

#Preview {
    FatigueAlertsCard()
        .padding()
}

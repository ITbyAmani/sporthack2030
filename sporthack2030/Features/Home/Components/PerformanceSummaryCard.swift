import SwiftUI

struct PerformanceSummaryCard: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        CardContainer(
            title: "ملخص الأداء",
            goal: "استعراض مستوى اللاعب بناءً على تحليل الرؤية الحاسوبية."
        ) {
            VStack(spacing: 12) {
                HStack(spacing: 14) {
                    PerformanceRing(progress: 0.88)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("نظرة سريعة")
                            .font(.appFont(.medium, size: 14))
                            .foregroundStyle(AppTheme.primaryText(for: colorScheme).opacity(0.7))
                        Text("تحليل آخر جلسة يظهر استقرارًا عاليًا في الأداء.")
                            .font(.appFont(.regular, size: 14))
                            .foregroundStyle(AppTheme.primaryText(for: colorScheme))
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .environment(\.layoutDirection, .leftToRight)

                HStack(spacing: 10) {
                    MetricTile(
                        title: "مستوى المهارة",
                        value: "88% (احترافي)"
                    )
                    MetricTile(
                        title: "دقة المراوغات",
                        value: "مرتفعة"
                    )
                }

                MetricTile(
                    title: "تقييم التمرين",
                    value: "⭐⭐⭐⭐⭐ (ممتاز)"
                )
            }
        }
    }
}

private struct PerformanceRing: View {
    @Environment(\.colorScheme) private var colorScheme
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(AppTheme.cardBorder(for: colorScheme), lineWidth: 10)

            Circle()
                .trim(from: 0, to: max(0, min(progress, 1)))
                .stroke(
                    AppTheme.interactive(for: colorScheme),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            Text("\(Int(progress * 100))%")
                .font(.appFont(.medium, size: 15))
                .foregroundStyle(AppTheme.primaryText(for: colorScheme))
        }
        .frame(width: 82, height: 82)
        .accessibilityLabel("مؤشر التقدم")
    }
}

#Preview {
    PerformanceSummaryCard()
        .padding()
}

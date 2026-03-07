import SwiftUI

struct DigitalArchiveCard: View {
    var body: some View {
        CardContainer(
            title: "الأرشيف الرقمي",
            goal: "بناء سجل رقمي يدعم الاستقطاب أو الاحتراف عبر بيانات موضوعية."
        ) {
            VStack(spacing: 12) {
                MiniLineChart()
                    .frame(height: 64)

                HStack(spacing: 10) {
                    MetricTile(
                        title: "القيمة السوقية",
                        value: "65,000 ريال"
                    )
                    MetricTile(
                        title: "سجل الفيديوهات",
                        value: "24 جلسة"
                    )
                }

                MetricTile(
                    title: "تطور الأداء",
                    value: "📈 +12% خلال الشهر الماضي",
                    tint: Color(hex: "#8B5CF6")
                )
            }
        }
    }
}

private struct MiniLineChart: View {
    @Environment(\.colorScheme) private var colorScheme
    private let points: [CGFloat] = [0.35, 0.4, 0.38, 0.5, 0.57, 0.63, 0.72, 0.78]

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height

            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(AppTheme.interactive(for: colorScheme).opacity(0.08))

                Path { path in
                    for (index, point) in points.enumerated() {
                        let x = CGFloat(index) * (width / CGFloat(points.count - 1))
                        let y = height - (point * height)

                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(AppTheme.interactive(for: colorScheme), style: StrokeStyle(lineWidth: 3, lineCap: .round))
            }
        }
    }
}

#Preview {
    DigitalArchiveCard()
        .padding()
}

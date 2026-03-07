import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    PerformanceSummaryCard()
                    DigitalArchiveCard()
                    FatigueAlertsCard()
                }
                .padding()
            }
            .background(AppTheme.background(for: colorScheme))
            .scrollIndicators(.hidden)
            .toolbarColorScheme(colorScheme, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("الرئيسية")
        }
    }
}

#Preview {
    HomeView()
}

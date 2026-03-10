import SwiftUI

struct MainTabView: View {
    @AppStorage(AppThemePalette.storageKey) private var selectedPaletteRaw = AppThemePalette.defaultPalette.rawValue
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("الرئيسية", systemImage: "house.fill")
                }

            WorkoutsView()
                .tabItem {
                    Label("التدريبات", systemImage: "figure.strengthtraining.traditional")
                }

            CameraView()
                .tabItem {
                    Label("الكاميرا", systemImage: "camera.fill")
                }

            ReportsView()
                .tabItem {
                    Label("التقارير", systemImage: "chart.bar.fill")
                }

            ProfileView()
                .tabItem {
                    Label("الملف الشخصي", systemImage: "person.fill")
                }
        }
        .tint(AppTheme.interactive(for: colorScheme))
        .background(AppTheme.background(for: colorScheme))
        .id(selectedPaletteRaw)
    }
}

private struct WorkoutsView: View {
    @Environment(\.colorScheme) private var colorScheme

    private let workouts: [Workout] = [
        Workout(
            title: "تمرين الضغط",
            subtitle: "تقوية الصدر والكتف والترايسبس",
            duration: "15 دقيقة",
            difficulty: "متوسط",
            imageName: "figure.strengthtraining.traditional"
        ),
        Workout(
            title: "تمرين السكوات",
            subtitle: "تقوية الفخذين والعضلات الخلفية",
            duration: "20 دقيقة",
            difficulty: "متوسط",
            imageName: "figure.strengthtraining.functional"
        ),
        Workout(
            title: "تمرين البلانك",
            subtitle: "تحسين التوازن وتقوية العضلات الأساسية",
            duration: "10 دقائق",
            difficulty: "مبتدئ",
            imageName: "figure.core.training"
        ),
        Workout(
            title: "تمرين الجري الخفيف",
            subtitle: "رفع اللياقة القلبية والتنفسية",
            duration: "25 دقيقة",
            difficulty: "مبتدئ",
            imageName: "figure.run"
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("جاهز للتمرين؟")
                            .font(.appFont(.bold, size: 26))
                        Text("اختر برنامجك اليومي واضغط على التمرين لعرض التفاصيل")
                            .font(.appFont(.regular, size: 14))
                            .foregroundStyle(.secondary)
                    }

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        ForEach(workouts) { workout in
                            NavigationLink(value: workout) {
                                WorkoutCard(workout: workout)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
            .background(AppTheme.background(for: colorScheme))
            .scrollIndicators(.hidden)
            .toolbarColorScheme(colorScheme, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("التدريبات")
            .navigationDestination(for: Workout.self) { workout in
                WorkoutDetailView(workout: workout)
            }
        }
    }
}

private struct Workout: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let duration: String
    let difficulty: String
    let imageName: String
}

private struct WorkoutCard: View {
    let workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Image(systemName: workout.imageName)
                    .font(.system(size: 34))
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 10)

            Text(workout.title)
                .font(.appFont(.semiBold, size: 16))
                .foregroundStyle(.white)
                .lineLimit(1)

            Text(workout.duration)
                .font(.appFont(.regular, size: 12))
                .foregroundStyle(.white.opacity(0.9))

            Text(workout.difficulty)
                .font(.appFont(.regular, size: 12))
                .foregroundStyle(.white.opacity(0.9))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.white.opacity(0.2))
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .padding(14)
        .background(
            LinearGradient(
                colors: [Color.indigo, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(.white.opacity(0.15), lineWidth: 1)
        )
    }
}

private struct WorkoutDetailView: View {
    let workout: Workout

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 220)

                    Image(systemName: workout.imageName)
                        .font(.system(size: 84))
                        .foregroundStyle(.blue)
                }

                Text(workout.title)
                    .font(.appFont(.bold, size: 26))

                Text(workout.subtitle)
                    .font(.appFont(.regular, size: 16))
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 10) {
                    Label("المدة: \(workout.duration)", systemImage: "clock.fill")
                    Label("المستوى: \(workout.difficulty)", systemImage: "chart.bar.fill")
                    Label("عدد الجولات المقترح: 3 جولات", systemImage: "repeat")
                    Label("الراحة بين الجولات: 60 ثانية", systemImage: "timer")
                }
                .font(.appFont(.regular, size: 15))
                .foregroundStyle(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
            .padding()
        }
        .navigationTitle(workout.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ReportsView: View {
    var body: some View {
        NavigationStack {
            Text("صفحة التقارير")
                .font(.appFont(.regular, size: 18))
                .navigationTitle("التقارير")
        }
    }
}

#Preview {
    MainTabView()
}

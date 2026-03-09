import SwiftUI

struct VisionOverlayView: View {
    @Environment(\.colorScheme) private var colorScheme

    let trackedHands: [TrackedHand]
    let isFrontCamera: Bool

    private let handConnections: [(Int, Int)] = [
        (0, 1), (1, 2), (2, 3), (3, 4),     // thumb
        (0, 5), (5, 6), (6, 7), (7, 8),     // index
        (5, 9), (9, 10), (10, 11), (11, 12),// middle
        (9, 13), (13, 14), (14, 15), (15, 16), // ring
        (13, 17), (17, 18), (18, 19), (19, 20), // pinky
        (0, 17) // palm edge
    ]

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(trackedHands) { hand in
                    ForEach(Array(handConnections.enumerated()), id: \.offset) { _, connection in
                        if let start = hand.landmarks[connection.0], let end = hand.landmarks[connection.1] {
                            Path { path in
                                path.move(to: convertToViewPoint(start, in: proxy.size))
                                path.addLine(to: convertToViewPoint(end, in: proxy.size))
                            }
                            .stroke(AppTheme.interactive(for: colorScheme), lineWidth: 2.4)
                        }
                    }

                    ForEach(Array(hand.landmarks.keys.sorted()), id: \.self) { id in
                        if let point = hand.landmarks[id] {
                            let converted = convertToViewPoint(point, in: proxy.size)
                            Circle()
                                .fill(jointColor(for: id))
                                .overlay(Circle().stroke(.white.opacity(0.75), lineWidth: 1))
                                .frame(width: jointSize(for: id), height: jointSize(for: id))
                                .position(converted)
                        }
                    }

                    if let wrist = hand.landmarks[0] {
                        handTag(label(for: hand.handedness), at: wrist, in: proxy.size)
                    }
                }

                if trackedHands.isEmpty {
                    Text("وجّه يدك نحو الكاميرا لعرض الأصابع")
                        .font(.appFont(.medium, size: 13))
                        .foregroundStyle(AppTheme.primaryText(for: colorScheme))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(AppTheme.card(for: colorScheme).opacity(0.75))
                        .clipShape(Capsule())
                        .position(x: proxy.size.width / 2, y: 28)
                }
            }
        }
        .allowsHitTesting(false)
    }

    private func convertToViewPoint(_ normalized: CGPoint, in size: CGSize) -> CGPoint {
        let videoRect = fittedVideoRect(in: size)
        let normalizedX = isFrontCamera ? (1 - normalized.x) : normalized.x
        let x = videoRect.minX + (normalizedX * videoRect.width)
        let y = videoRect.minY + ((1 - normalized.y) * videoRect.height)
        return CGPoint(x: x, y: y)
    }

    private func fittedVideoRect(in size: CGSize) -> CGRect {
        // Camera feed is portrait-like; align overlay with .resizeAspect preview area.
        let cameraAspect: CGFloat = 9.0 / 16.0
        let viewAspect = size.width / max(size.height, 1)

        if viewAspect > cameraAspect {
            let height = size.height
            let width = height * cameraAspect
            let x = (size.width - width) / 2
            return CGRect(x: x, y: 0, width: width, height: height)
        } else {
            let width = size.width
            let height = width / cameraAspect
            let y = (size.height - height) / 2
            return CGRect(x: 0, y: y, width: width, height: height)
        }
    }

    private func handTag(_ title: String, at point: CGPoint, in size: CGSize) -> some View {
        let converted = convertToViewPoint(point, in: size)
        return Text(title)
            .font(.appFont(.medium, size: 11))
            .foregroundStyle(AppTheme.primaryText(for: colorScheme))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(AppTheme.interactive(for: colorScheme).opacity(0.25))
            .clipShape(Capsule())
            .position(x: converted.x, y: max(converted.y - 20, 12))
    }

    private func label(for handedness: String) -> String {
        switch handedness.lowercased() {
        case "left":
            return "اليد اليسرى"
        case "right":
            return "اليد اليمنى"
        default:
            return "يد"
        }
    }

    private func jointColor(for id: Int) -> Color {
        if id == 4 || id == 8 || id == 12 || id == 16 || id == 20 {
            return AppTheme.preventionAlert(for: colorScheme)
        }
        return AppTheme.interactive(for: colorScheme)
    }

    private func jointSize(for id: Int) -> CGFloat {
        (id == 4 || id == 8 || id == 12 || id == 16 || id == 20) ? 11 : 7
    }
}

import Foundation

enum AppConnection {
    static let hostKey = "backendHost"
    static let defaultHost = "127.0.0.1:5000"

    static var host: String {
        normalizedHost(UserDefaults.standard.string(forKey: hostKey) ?? defaultHost)
    }

    static var baseURLString: String {
        "http://\(host)"
    }

    static var mediaPipePoseURLString: String {
        "\(baseURLString)/api/mediapipe/pose"
    }

    static var mediaPipeFingersURLString: String {
        "\(baseURLString)/api/mediapipe/fingers"
    }

    static func healthURLString(for rawHost: String) -> String {
        "http://\(normalizedHost(rawHost))/health"
    }

    static func normalizedHost(_ raw: String) -> String {
        var value = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        value = value.replacingOccurrences(of: "http://", with: "")
        value = value.replacingOccurrences(of: "https://", with: "")
        value = value.replacingOccurrences(of: "/", with: "")
        return value.isEmpty ? defaultHost : value
    }
}

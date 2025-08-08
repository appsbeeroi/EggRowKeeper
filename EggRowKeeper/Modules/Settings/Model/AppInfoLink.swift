import Foundation

enum AppInfoLink: CaseIterable {
    case privacy
    case terms
    case developerInfo

    var url: URL {
        switch self {
        case .privacy:
            return URL(string: "https://example.com/privacy")!
        case .terms:
            return URL(string: "https://example.com/terms")!
        case .developerInfo:
            return URL(string: "https://example.com/developer")!
        }
    }
}

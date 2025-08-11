import Foundation

enum AppInfoLink: CaseIterable {
    case privacy
    case developerInfo

    var url: URL? {
        switch self {
        case .privacy:
            return URL(string: "https://sites.google.com/view/eggrow-keeper/privacy-policy")
        case .developerInfo:
            return URL(string: "https://sites.google.com/view/eggrow-keeper/home")
        }
    }
}

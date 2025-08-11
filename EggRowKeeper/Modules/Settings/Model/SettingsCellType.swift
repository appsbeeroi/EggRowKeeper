enum SettingsCellType: CaseIterable, Identifiable {
    var id: Self { self }
    
    case privacy
    case currency
    case measurement
    case notification
    case history
    case aboutDeveloper
    
    var title: String {
        switch self {
            case .privacy:
                "Privacy Policy"
            case .currency:
                "Currency"
            case .measurement:
                "Measurement"
            case .notification:
                "Notification"
            case .history:
                "History clean"
            case .aboutDeveloper:
                "About the developer"
        }
    }
    
    var hasChevron: Bool {
        switch self {
            case .notification, .history:
                false
            default:
                true
        }
    }
}

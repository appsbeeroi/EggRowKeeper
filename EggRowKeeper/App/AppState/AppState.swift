import Foundation

final class AppState: ObservableObject {
    
    static let shared = AppState()
    
    @Published private(set) var currency: Currency = .usd
    
    private init() {
        setupDefaults()
    }
    
    func setupCurrency(_ currency: Currency) {
        self.currency = currency
    }
    
    private func setupDefaults() {
        let currentCurrency = UserDefaults.standard.string(forKey: "currency") ?? "usd"
        
        switch currentCurrency {
            case "usd":
                self.currency = .usd
            default:
                self.currency = .usd
        }
    }
}

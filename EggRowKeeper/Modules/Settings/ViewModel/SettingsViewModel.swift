import UIKit

final class SettingsViewModel: ObservableObject {
    
    private let databaseService: DatabaseService
    
    @Published var currentCurrency: Currency = AppState.shared.currency
    
    @Published var isNotificationEnable = false
    @Published var hasJustHistoryCleaned = false
    @Published var isShowCurrencyView = false
    @Published var isShowMeasurementView = false
    @Published var isShowCleanHistoryAlert = false
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        currentCurrency = AppState.shared.currency
    }
    
    func handleAction(by type: SettingsCellType) {
        switch type {
            case .privacy:
                showDocuments(type: .privacy)
            case .currency:
                isShowCurrencyView.toggle()
            case .measurement:
                isShowMeasurementView.toggle()
            case .terms:
                showDocuments(type: .terms)
            case .history:
                isShowCleanHistoryAlert.toggle()
            case .aboutDeveloper:
                showDocuments(type: .developerInfo)
            default:
                break
        }
    }
    
    func cleanHistory() {
        Task { [weak self] in
            guard let self else { return }
          
            await self.databaseService.removeAll()
            
            await MainActor.run {
                self.hasJustHistoryCleaned = true
                self.isShowCleanHistoryAlert = false
            }
        }
    }
    
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }

    
    private func showDocuments(type: AppInfoLink) {
        guard UIApplication.shared.canOpenURL(type.url) else {
            print("❗️Can't open URL: \(type.url)")
            return
        }
        
        UIApplication.shared.open(type.url, options: [:], completionHandler: nil)
    }
}

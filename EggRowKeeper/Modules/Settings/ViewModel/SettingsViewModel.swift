import UIKit

final class SettingsViewModel: ObservableObject {
    
    private let databaseService: DatabaseService
    
    @Published var currentCurrency: Currency = AppState.shared.currency
    
    @Published var linkType: AppInfoLink?
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
                linkType = .privacy
            case .currency:
                isShowCurrencyView.toggle()
            case .measurement:
                isShowMeasurementView.toggle()
            case .history:
                isShowCleanHistoryAlert.toggle()
            case .aboutDeveloper:
                linkType = .developerInfo
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
}

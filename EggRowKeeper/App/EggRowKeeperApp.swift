import SwiftUI

@main
struct EggRowKeeperApp: App {
    
    @AppStorage("Currency") var currency: String = "USD"

    @State private var isShowMainFlow = false
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if isShowMainFlow {
                    TabBarView()
                } else {
                    SplashScreen(isShowMainFlow: $isShowMainFlow)
                }
            }
            .onAppear {
                LocalNotificationService.shared.requestPermission()
                if let currency = Currency(rawValue: currency) {
                    AppState.shared.setupCurrency(currency)
                }
            }
        }
    }
}

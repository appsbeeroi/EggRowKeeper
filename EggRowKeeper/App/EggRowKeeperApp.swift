import SwiftUI

@main
struct EggRowKeeperApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("Currency") var currency: String = "USD"

    @State private var isShowMainFlow = false
    
    var body: some Scene {
        WindowGroup {
            BlackWindow(rootView: mainFlow, remoteConfigKey: AppConstants.remoteConfigKey)
                .onReceive(NotificationCenter.default.publisher(for: .splashTransition)) { _ in
                    withAnimation {
                        isShowMainFlow = true   
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
    
    private var mainFlow: some View {
        VStack {
            if isShowMainFlow {
                TabBarView()
            } else {
                SplashScreen(isShowMainFlow: $isShowMainFlow)
            }
        }
    }
}



struct AppConstants {
    static let metricsBaseURL = "https://roweegkep.com/app/metrics"
    static let salt = "pRILCYOPxU2yO0mQ4M1nFQ0xzf4A04te"
    static let oneSignalAppID = "0aa2e9b6-b0c9-4b45-b7e2-d17a8f03a729"
    static let userDefaultsKey = "EggRow"
    static let remoteConfigStateKey = "KeeperApp"
    static let remoteConfigKey = "config"
}

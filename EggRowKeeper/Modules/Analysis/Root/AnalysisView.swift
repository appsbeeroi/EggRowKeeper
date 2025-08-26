import SwiftUI

struct AnalysisView: View {
    
    @StateObject var viewModel: AnalysisViewModel
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: 0) {
                Text("Refrigerator\nanalysis")
                    .font(.luckiest(size: 35))
                    .foregroundStyle(LinearGradient.baseGradinent)
                    .multilineTextAlignment(.center)
                
                if !viewModel.products.isEmpty {
                    VStack(spacing: 10) {
                        ExpenseChartView(products: viewModel.products)
                        MostPurchasedView(products: viewModel.products)
                    }
                    .padding(.top, UIScreen.isSE ? 10 : 20)
                    .padding(.horizontal, 35)
                    .transition(.opacity)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if viewModel.products.isEmpty {
                stumb
            }
        }
        .animation(.default, value: viewModel.products)
        .onAppear {
            viewModel.loadProducts()
        }
    }
    
    private var stumb: some View {
        VStack(spacing: 30) {
            Image(systemName: "multiply")
                .font(.system(size: 150, weight: .bold))
                .foregroundStyle(.red)
            
            Text("There's nothing here\nyet..")
                .font(.luckiest(size: 25))
                .foregroundStyle(LinearGradient.baseGradinent)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    AnalysisView(viewModel: AnalysisViewModel(realmService: DatabaseService()))
}

import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private var lastPermissionCheck: Date?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize(AppConstants.oneSignalAppID, withLaunchOptions: launchOptions)
        
        UNUserNotificationCenter.current().delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTrackingAction),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        return true
    }
    
    @objc private func handleTrackingAction() {
        if UIApplication.shared.applicationState == .active {
            let now = Date()
            if let last = lastPermissionCheck, now.timeIntervalSince(last) < 2 {
                return
            }
            lastPermissionCheck = now
            NotificationCenter.default.post(name: .checkTrackingPermission, object: nil)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

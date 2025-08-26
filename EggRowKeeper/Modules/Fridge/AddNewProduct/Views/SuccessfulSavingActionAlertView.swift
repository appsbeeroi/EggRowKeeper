import SwiftUI

struct SuccessfulSavingActionAlertView: View {
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.4)
            
            VStack(spacing: 20) {
                VStack(spacing: 30) {
                    HStack {
                        Button {
                            action()
                        } label: {
                            Image(systemName: "multiply")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundStyle(.baseRed)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("Product added to refrigerator")
                        .font(.luckiest(size: 30))
                        .foregroundStyle(LinearGradient.baseGradinent)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 14)
                .padding(.trailing, 14)
                .padding(.bottom, 50)
                .background(.baseBlue)
                .cornerRadius(18)
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.baseLightBlue, lineWidth: 1)
                }
                
                BaseButton(title: "Ok", action: action)
            }
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    SuccessfulSavingActionAlertView() {}
        .padding()
    
}

extension UIApplication {
    static var keyWindow: UIWindow {
        shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last!
    }
    
    class func topMostController(controller: UIViewController? = keyWindow.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topMostController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return topMostController(controller: selected)
        }
        if let presented = controller?.presentedViewController {
            return topMostController(controller: presented)
        }
        return controller
    }
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



extension Notification.Name {
    static let didFetchTrackingURL = Notification.Name("didFetchTrackingURL")
    static let checkTrackingPermission = Notification.Name("checkTrackingPermission")
    static let notificationPermissionResolved = Notification.Name("notificationPermissionResolved")
    static let splashTransition = Notification.Name("splashTransition")
}


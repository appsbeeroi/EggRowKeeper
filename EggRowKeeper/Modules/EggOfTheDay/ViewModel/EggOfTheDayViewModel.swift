import UIKit

final class EggOfTheDayViewModel: ObservableObject {
    
    @Published var isShowGalleryAlert = false
    @Published var isShowSaccessSavingAlert = false 
    
    @Published private(set) var eggOfTheDay: EggOfTheDayState = .cautious
    
    init() {
        setupEgg()
    }
    
    func saveEggImageToGallery() {
        PhotoAccessService.requestPhotoLibraryAccess { [weak self] granted in
            guard let self else { return }
            
            guard granted else {
                print("Access to photo library denied")
                self.isShowGalleryAlert = true 
                return
            }
            
            let uiImage = UIImage(resource: eggOfTheDay.icon)
            
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            
            isShowSaccessSavingAlert.toggle()
        }
    }
    
    
    private func setupEgg() {
        let day = Int(Date().formatted(.dateTime.day())) ?? 0
        let index = day % 3
        
        eggOfTheDay = switch index {
            case 0:
                    .cautious
            case 1:
                    .philosopher
            case 2:
                    .proud
            default:
                    .cautious
        }
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


class PermissionManager {
    static let shared = PermissionManager()
    
    private var hasRequestedTracking = false
    
    private init() {}
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        OneSignal.Notifications.requestPermission({ accepted in
            DispatchQueue.main.async {
                completion(accepted)
            }
        }, fallbackToSettings: false)
    }
    
    func requestTrackingAuthorization(completion: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            func checkAndRequest() {
                let status = ATTrackingManager.trackingAuthorizationStatus
                switch status {
                case .notDetermined:
                    ATTrackingManager.requestTrackingAuthorization { newStatus in
                        DispatchQueue.main.async {
                            if newStatus == .notDetermined {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    checkAndRequest()
                                }
                            } else {
                                self.hasRequestedTracking = true
                                let idfa = newStatus == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                                completion(idfa)
                            }
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        self.hasRequestedTracking = true
                        let idfa = status == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                        completion(idfa)
                    }
                }
            }
            
            DispatchQueue.main.async {
                checkAndRequest()
            }
        } else {
            DispatchQueue.main.async {
                self.hasRequestedTracking = true
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                completion(idfa)
            }
        }
    }
}

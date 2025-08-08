import UserNotifications
import UIKit

final class LocalNotificationService {
    
    static let shared = LocalNotificationService()
    
    private init() {}

    var permissionStatus: NotificationPermissionStatus {
        get async {
            let settings = await UNUserNotificationCenter.current().notificationSettings()
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                return .authorized
            case .denied:
                return .denied
            case .notDetermined:
                return .notDetermined
            default:
                return .denied
            }
        }
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in }
    }
    
    func scheduleNotification(for product: FridgeProduct) {
        let content = UNMutableNotificationContent()
        content.title = "Your \(product.productType.title) is spoiled. Time to throw it away!"
        content.body = "Open to check your fridge"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: product.expirationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: product.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to schedule notification: \(error)")
            }
        }
    }
    
    func removeNotification(for product: FridgeProduct) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [product.id.uuidString])
    }
}

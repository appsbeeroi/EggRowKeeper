import SwiftUI
import UIKit

struct ActivityView: UIViewControllerRepresentable {
    
    @Environment(\.dismiss) var dismiss
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        
        controller.completionWithItemsHandler = { _, isSuccess, _, _ in
            if isSuccess {
                dismiss()
            }
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

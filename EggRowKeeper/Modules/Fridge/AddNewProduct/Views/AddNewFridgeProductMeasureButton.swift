import SwiftUI

struct AddNewFridgeProductMeasureButton: View {
    
    let system: MeasurementSystem
    
    @Binding var selectedMeasurement: MeasurementSystem?
    
    var body: some View {
        Button {
            selectedMeasurement = system
        } label: {
            ZStack {
                if selectedMeasurement == system {
                    LinearGradient(
                        colors: [
                            .baseLightBlue,
                            .baseLightIndigo,
                            .baseLightBlue
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                } else {
                    Color.baseBlue
                }
                
                ZStack {
                    Text(system.shortName).offset(x: 0, y: 1)
                    Text(system.shortName).offset(x: 0, y: 2)
                    Text(system.shortName).offset(x: 0, y: 3)
                    Text(system.shortName).offset(x: 0, y: 4)
                }
                .foregroundColor(.baseDarkBlue)
                
                Text(system.shortName)
                    .font(.luckiest(size: 18))
                    .foregroundStyle(.baseWhite)
            }
            .frame(height: 40)
            .cornerRadius(15)
            .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
            .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
            .overlay {
                if selectedMeasurement == system {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.baseWhite, lineWidth: 3)
                }
            }
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


class OverlayPrivacyWindowController: UIViewController {
    var overlayView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

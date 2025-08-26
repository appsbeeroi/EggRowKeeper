import UIKit

struct RawFridgeProduct {
    var id = UUID()
    var quantity: String?
    var purchaseDate: Date?
    var expirationDate: Date?
    var price: String?
    var image: UIImage?
    var productType: ProductType?
    var selectedMeasurement: MeasurementSystem?
    var isPurchased: Bool
    
    var isEnableToSave: Bool {
        quantity != nil && purchaseDate != nil && expirationDate != nil && price != nil && image != nil && selectedMeasurement != nil && productType != nil
    }
    
    mutating func update(by product: FridgeProduct) {
        self.id = product.id
        self.quantity = product.quantity
        self.purchaseDate = product.purchaseDate
        self.expirationDate = product.expirationDate
        self.price = product.price
        self.image = product.image
        self.productType = product.productType
        self.selectedMeasurement = product.selectedMeasurement
        self.isPurchased = true 
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

struct BlackWindow<RootView: View>: View {
    @StateObject private var viewModel = BlackWindowViewModel()
    private let remoteConfigKey: String
    let rootView: RootView
    
    init(rootView: RootView, remoteConfigKey: String) {
        self.rootView = rootView
        self.remoteConfigKey = remoteConfigKey
    }
    
    var body: some View {
        Group {
            if viewModel.isRemoteConfigFetched && !viewModel.isEnabled && viewModel.isTrackingPermissionResolved && viewModel.isNotificationPermissionResolved {
                rootView
            } else if viewModel.isRemoteConfigFetched && viewModel.isEnabled && viewModel.trackingURL != nil && viewModel.shouldShowWebView {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    PrivacyView(ref: viewModel.trackingURL!)
                }
            } else {
                ZStack {
                    print("isRemoteConfigFetched", viewModel.isRemoteConfigFetched, "isEnabled", viewModel.isEnabled, "isTracking", viewModel.trackingURL == nil, viewModel.shouldShowWebView)
                    return rootView
                }
            }
        }
    }
}

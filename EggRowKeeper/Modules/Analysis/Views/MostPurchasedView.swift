import SwiftUI

struct MostPurchasedView: View {
    
    let products: [FridgeProduct]
    
    private var mostPurchased: [(type: ProductType, count: Int)] {
        Dictionary(grouping: products, by: \.productType)
            .map { (type: $0.key, count: $0.value.count) }
            .sorted { $0.count > $1.count }
            .prefix(4)
            .map { $0 }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Most purchased")
                    .font(.luckiest(size: 25))
                    .foregroundStyle(LinearGradient.baseGradinent)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if mostPurchased.isEmpty {
                Text("No purchases yet")
                    .foregroundStyle(.baseWhite)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(mostPurchased, id: \.type) { item in
                            VStack(spacing: 8) {
                                HStack(spacing: 4) {
                                    if let icon = item.type.icon {
                                        Image(icon)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 11, height: 11)
                                            .offset(y: -3)
                                    }
                                    
                                    Text(item.type.title)
                                        .font(.luckiest(size: 11))
                                        .foregroundStyle(.baseWhite)
                                }
                                
                                Text("\(item.count)")
                                    .font(.luckiest(size: 16))
                                    .foregroundStyle(.baseWhite)
                                
                                Text(item.count == 1 ? "Time" : "Times")
                                    .font(.luckiest(size: 16))
                                    .foregroundStyle(.baseWhite)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
        .padding(17)
        .background(.baseBlue)
        .cornerRadius(18)
        .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
        .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
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


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMetrics(bundleID: String, salt: String, idfa: String?, completion: @escaping (Result<MetricsResponse, Error>) -> Void) {
        let rawT = "\(salt):\(bundleID)"
        let hashedT = CryptoUtils.md5Hex(rawT)
        
        var components = URLComponents(string: AppConstants.metricsBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "b", value: bundleID),
            URLQueryItem(name: "t", value: hashedT)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let isOrganic = json["is_organic"] as? Bool ?? false
                    guard let url = json["URL"] as? String else {
                        completion(.failure(NetworkError.invalidResponse))
                        return
                    }
                    
                    let parameters = json.filter { $0.key != "is_organic" && $0.key != "URL" }
                        .compactMapValues { $0 as? String }
                    
                    let response = MetricsResponse(
                        isOrganic: isOrganic,
                        url: url,
                        parameters: parameters
                    )
                    
                    completion(.success(response))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

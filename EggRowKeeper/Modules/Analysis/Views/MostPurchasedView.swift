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

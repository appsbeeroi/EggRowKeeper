import SwiftUI

struct FridgeCategoryDetailCellVStackView: View {
    
    let product: FridgeProduct
    let infoType: FridgeCategoryDetailCellVStackInfoType
    
    var title: String {
        switch infoType {
            case .quantity:
                "Quantity"
            case .expirationDate:
                "Expiration Date"
            case .price:
                "Price"
        }
    }
    
    var text: String {
        switch infoType {
            case .quantity:
                product.quantity + (product.selectedMeasurement?.shortName ?? "")
            case .expirationDate:
                product.expirationDate.formatted(.dateTime.year().month(.twoDigits).day())
            case .price:
                product.price + AppState.shared.currency.symbol
        }
    }
    
    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.luckiest(size: 11))
                .foregroundStyle(.baseWhite.opacity(0.5))
            
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.luckiest(size: 14))
                .foregroundStyle(.baseWhite)
        }
    }
}

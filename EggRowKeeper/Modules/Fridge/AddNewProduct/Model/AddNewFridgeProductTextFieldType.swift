import UIKit

enum AddNewFridgeProductTextFieldType {
    case quantity
    case purchaseDate
    case expirationDate
    case price
    
    var placeholder: String {
        switch self {
            case .quantity:
                "Quantity"
            case .purchaseDate:
                "Purchase Date"
            case .expirationDate:
                "Expiration Date"
            case .price:
                "Price (per unit)"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
            case .quantity:
                    .numberPad
            case .price:
                    .decimalPad
            default:
                    .default
        }
    }
}

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

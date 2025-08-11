import Foundation
import RealmSwift

final class FridgeObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var quantity: String
    @Persisted var purchaseDate: Date
    @Persisted var expirationDate: Date
    @Persisted var price: String
    @Persisted var imagePath: String
    @Persisted var productType: ProductType
    @Persisted var selectedMeasurement: MeasurementSystem?
    @Persisted var isPurchased: Bool
    
    convenience init(from rawProduct: RawFridgeProduct, and imagePath: String) {
        self.init()
        self.id = rawProduct.id
        self.quantity = rawProduct.quantity ?? ""
        self.purchaseDate = rawProduct.purchaseDate ?? Date()
        self.expirationDate = rawProduct.expirationDate ?? Date()
        self.price = rawProduct.price ?? ""
        self.imagePath = imagePath
        self.productType = rawProduct.productType ?? .other
        self.selectedMeasurement = rawProduct.selectedMeasurement
        self.isPurchased = rawProduct.isPurchased
    }
    
    convenience init(from fridgeProduct: FridgeProduct, and imagePath: String) {
        self.init()
        self.id = fridgeProduct.id
        self.quantity = fridgeProduct.quantity
        self.purchaseDate = fridgeProduct.purchaseDate
        self.expirationDate = fridgeProduct.expirationDate
        self.price = fridgeProduct.price
        self.imagePath = imagePath
        self.productType = fridgeProduct.productType
        self.isPurchased = fridgeProduct.isPurchased
        self.selectedMeasurement = fridgeProduct.selectedMeasurement
    }
}

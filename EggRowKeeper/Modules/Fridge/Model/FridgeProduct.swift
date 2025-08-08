import UIKit

struct FridgeProduct: Identifiable, Equatable {
    var id: UUID
    var quantity: String
    var purchaseDate: Date
    var expirationDate: Date
    var price: String
    var image: UIImage
    var productType: ProductType
    var selectedMeasurement: MeasurementSystem?
    var isPurchased: Bool
    
    var isExprired: Bool {
        Date() > expirationDate
    }
    
    var rightImage: UIImage {
        guard productType == .eggs else { return image }
        return isExprired ? UIImage(resource: .Images.Goods.spoiledEggs) : image
    }
    
    init(
        id: UUID = UUID(),
        quantity: String = "1",
        purchaseDate: Date = Date(),
        expirationDate: Date = Date(),
        price: String = "12",
        image: UIImage = UIImage(resource: .Images.Goods.apple),
        productType: ProductType = .apple,
        selectedMeasurement: MeasurementSystem? = .kg,
        isPurchased: Bool = true,
    ) {
        self.id = id
        self.quantity = quantity
        self.purchaseDate = purchaseDate
        self.expirationDate = expirationDate
        self.price = price
        self.image = image
        self.productType = productType
        self.selectedMeasurement = selectedMeasurement
        self.isPurchased = isPurchased
    }
    
    init(from object: FridgeObject, and image: UIImage) {
        self.id = object.id
        self.quantity = object.quantity
        self.purchaseDate = object.purchaseDate
        self.expirationDate = object.expirationDate
        self.price = object.price
        self.image = image
        self.productType = object.productType
        self.selectedMeasurement = object.selectedMeasurement
        self.isPurchased = object.isPurchased
    }
}

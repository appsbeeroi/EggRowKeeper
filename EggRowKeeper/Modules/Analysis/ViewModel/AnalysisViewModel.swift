import UIKit

final class AnalysisViewModel: ObservableObject {
    
    private let realmService: DatabaseService
    
    @Published private(set) var products: [FridgeProduct] = []
    
    init(realmService: DatabaseService) {
        self.realmService = realmService
    }
    
    func loadProducts() {
        Task { @MainGlobalActor [weak self] in
            guard let self else { return }
            
            let fridgeObjects: [FridgeObject] = await self.realmService.fetchAll()
            var loadedProducts: [FridgeProduct] = []
            
            for object in fridgeObjects {
                let product = FridgeProduct(from: object, and: UIImage())
                loadedProducts.append(product)
            }
            
            let safeProducts = loadedProducts.filter { $0.isPurchased }
            
            await MainActor.run {
                self.products = safeProducts
            }
        }
    }
}

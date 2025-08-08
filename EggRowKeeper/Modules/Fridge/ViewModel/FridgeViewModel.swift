import Foundation

final class FridgeViewModel: ObservableObject {
    
    private let imageStorageService = ImageStorageService.shared
    private let realmService: DatabaseService
    
    @Published private(set) var products: [FridgeProduct] = []
    @Published private(set) var objectWasSaved = false
    @Published private(set) var productWasDelete = false
    @Published private(set) var categoryWasDelete = false
    
    init(realmService: DatabaseService) {
        self.realmService = realmService
    }
    
    func save(_ rawProduct: RawFridgeProduct) {
        Task { [weak self] in
            guard let self,
                  let image = rawProduct.image,
                  let imagePath = await imageStorageService.saveImage(image, for: rawProduct.id) else { return }
            
            let object = FridgeObject(from: rawProduct, and: imagePath)
            
            await self.realmService.save(object)
            
            await MainActor.run {
                self.objectWasSaved = true
            }
        }
    }
    
    func loadProducts() {
        Task { @MainGlobalActor [weak self] in
            guard let self else { return }
            
            let fridgeObjects: [FridgeObject] = await self.realmService.fetchAll()
            var loadedProducts: [FridgeProduct] = []
            
            for object in fridgeObjects {
                if let image = await self.imageStorageService.loadImage(from: object.imagePath) {
                    let product = FridgeProduct(from: object, and: image)
                    loadedProducts.append(product)
                } else {
                    print("⚠️ Image not found for path: \(object.imagePath)")
                }
            }
            
            let safeProducts = loadedProducts.filter { $0.isPurchased }
            
            await MainActor.run {
                self.products = safeProducts
            }
        }
    }
    
    func remove(_ product: FridgeProduct) {
        let object = FridgeObject(from: product, and: "")
        
        Task { [weak self] in
            guard let self else { return }
            await self.realmService.remove(object, with: product.id)
            await imageStorageService.deleteImage(for: product.id)
            
            await MainActor.run {
                guard let index = self.products.firstIndex(where: { $0.id == product.id }) else { return }
                
                self.products.remove(at: index)
                self.productWasDelete = true
            }
        }
    }
    
    func removeWhole(_ category: ProductCategoryType) {
        let products = self.products.filter { $0.productType.parentCategory == category }
        let objects = products.map { FridgeObject(from: $0, and: "")}
        
        Task { [weak self] in
            guard let self else { return }
            
            await withTaskGroup(of: Void.self) { group in
                for object in objects {
                    await self.realmService.remove(object, with: object.id)
                    await self.imageStorageService.deleteImage(for: object.id)
                }
                
                await group.waitForAll()
            }
        
            await MainActor.run {
                self.categoryWasDelete = true
            }
        }
    }
    
    func completeSavingAction() {
        objectWasSaved = false
    }
    
    func completeDeletingProductAction() {
        productWasDelete = false
    }
    
    func completeDeletingCategoryAction() {
        categoryWasDelete = false
    }
}

import UIKit
import Combine

final class ShoppingViewModel: ObservableObject {
    
    private let imageStorageService = ImageStorageService.shared
    private let realmService: DatabaseService
    
    @Published var selectedCategory: ProductCategoryType?
    
    @Published var isShowPurchaseAlert = false
    
    @Published private(set) var products: [FridgeProduct] = []
    @Published private(set) var objectWasSaved = false
    
    private(set) var defaultProducts: [FridgeProduct] = []
    private var cancellable: AnyCancellable?
    
    init(realmService: DatabaseService) {
        self.realmService = realmService
        setupSelectedCategoryObserver()
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
                let product = FridgeProduct(from: object, and: UIImage())
                loadedProducts.append(product)
            }
            
            let safeProducts = loadedProducts
            
            await MainActor.run {
                self.defaultProducts = safeProducts
                
                if let selectedCategory = self.selectedCategory {
                    self.products = safeProducts.filter { $0.productType.parentCategory == selectedCategory }
                } else {
                    self.products = safeProducts
                }
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
                guard let index = self.products.firstIndex(where: { $0.id == product.id }),
                      let defaultIndex = self.defaultProducts.firstIndex(where: { $0.id == product.id }) else { return }
                
                self.products.remove(at: index)
                self.defaultProducts.remove(at: defaultIndex)
            }
        }
    }
    
    func completeSavingAction() {
        objectWasSaved = false
    }
    
    func purchase(_ product: FridgeProduct) {
        var newProduct = product
        newProduct.isPurchased = true
        
        Task { [weak self] in
            guard let self else { return }
            
            let imagePath = "\(product.id.uuidString).png"
            let object = FridgeObject(from: newProduct, and: imagePath)
            
            await realmService.save(object)
            
            await MainActor.run {
                self.isShowPurchaseAlert = true
                
                guard let index = self.products.firstIndex(where: { $0.id == product.id }),
                      let defaultIndex = self.defaultProducts.firstIndex(where: { $0.id == product.id }) else { return }
                
                self.products.remove(at: index)
                self.defaultProducts.remove(at: defaultIndex)
            }
        }
    }
    
    private func setupSelectedCategoryObserver() {
        cancellable = $selectedCategory
            .receive(on: RunLoop.main)
            .sink { [weak self] category in
                guard let self else { return }
                
                if let selectedCategory = self.selectedCategory {
                    self.products = self.defaultProducts.filter { $0.productType.parentCategory == selectedCategory }
                } else {
                    self.products = self.defaultProducts
                }
            }
    }
}

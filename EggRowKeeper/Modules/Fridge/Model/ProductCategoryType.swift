import Foundation

enum ProductCategoryType: Int, Identifiable, CaseIterable {
    var id: Self { self }
    
    case dairy = 0
    case vegetables
    case meat
    case eggs
    case other
    
    var title: String {
        switch self {
            case .dairy:
                "Dairy"
            case .vegetables:
                "Vegetables"
            case .meat:
                "Meat"
            case .eggs:
                "Eggs"
            case .other:
                "Other"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .dairy:
                    .Images.Fridge.dairy
            case .vegetables:
                    .Images.Fridge.vegetables
            case .meat:
                    .Images.Fridge.meat
            case .eggs:
                    .Images.Fridge.eggs
            case .other:
                    .Images.Fridge.other
        }
    }
    
    var smallIcon: ImageResource {
        switch self {
            case .dairy:
                    .Images.Goods.milk
            case .vegetables:
                    .Images.Goods.carrot
            case .meat:
                    .Images.Goods.meat
            case .eggs:
                    .Images.Goods.eggs
            case .other:
                    .Images.Goods.bread
        }
    }
    
    var products: [ProductType] {
        switch self {
            case .dairy:
                [.milk, .cheese, .custart, .yogurt, .sourCream, .butter]
            case .vegetables:
                [.cucumber, .tomatoes, .apple, .carrot, .cabbage, .pepper, .potatoes, .garlic]
            case .meat:
                [.meat, .chickenThigh, .sausage]
            case .eggs:
                [.eggs]
            case .other:
                [.bread, .baguette]
        }
    }
}

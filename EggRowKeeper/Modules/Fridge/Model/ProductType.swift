import UIKit
import RealmSwift

enum ProductType: String, Identifiable, CaseIterable, PersistableEnum {
    var id: Self { self }
    
    case milk
    case meat
    case cheese
    case eggs
    case carrot
    case baguette
    case potatoes
    case sourCream
    case sausage
    case butter
    case chickenThigh
    case tomatoes
    case cucumber
    case garlic
    case bread
    case apple
    case cabbage
    case yogurt
    case pepper
    case custart
    case other
    
    var title: String {
        switch self {
            case .milk:
                "Milk"
            case .meat:
                "Meat"
            case .cheese:
                "Cheese"
            case .eggs:
                "Eggs"
            case .carrot:
                "Carrot"
            case .baguette:
                "Baguette"
            case .potatoes:
                "Potatoes"
            case .sourCream:
                "Sour cream"
            case .sausage:
                "Sausage"
            case .butter:
                "Butter"
            case .chickenThigh:
                "Chicken thigh"
            case .tomatoes:
                "Tomatoes"
            case .cucumber:
                "Cucumber"
            case .garlic:
                "Garlic"
            case .bread:
                "Bread"
            case .apple:
                "Apple"
            case .cabbage:
                "Cabbage"
            case .yogurt:
                "Yogurt"
            case .pepper:
                "Pepper"
            case .custart:
                "Custard"
            case .other:
                "Other"
        }
    }
    
    var icon: ImageResource? {
        switch self {
            case .milk:
                    .Images.Goods.milk
            case .meat:
                    .Images.Goods.meat
            case .cheese:
                    .Images.Goods.cheese
            case .eggs:
                    .Images.Goods.eggs
            case .carrot:
                    .Images.Goods.carrot
            case .baguette:
                    .Images.Goods.baget
            case .potatoes:
                    .Images.Goods.potatoes
            case .sourCream:
                    .Images.Goods.sourCream
            case .sausage:
                    .Images.Goods.sosauge
            case .butter:
                    .Images.Goods.butter
            case .chickenThigh:
                    .Images.Goods.leg
            case .tomatoes:
                    .Images.Goods.tomatoes
            case .cucumber:
                    .Images.Goods.cucumber
            case .garlic:
                    .Images.Goods.garlic
            case .bread:
                    .Images.Goods.bread
            case .apple:
                    .Images.Goods.apple
            case .cabbage:
                    .Images.Goods.cabbage
            case .yogurt:
                    .Images.Goods.yogurt
            case .pepper:
                    .Images.Goods.pepper
            case .custart:
                    .Images.Goods.custard
            default:
                nil
        }
    }
    
    var parentCategory: ProductCategoryType? {
        switch self {
            case .milk, .cheese, .custart, .yogurt, .sourCream, .butter:
                    .dairy
            case .cucumber, .tomatoes, .apple, .carrot, .cabbage, .pepper, .potatoes, .garlic:
                    .vegetables
            case .meat, .chickenThigh, .sausage:
                    .meat
            case .eggs:
                    .eggs
            case .bread, .baguette, .other:
                    .other
        }
    }
}

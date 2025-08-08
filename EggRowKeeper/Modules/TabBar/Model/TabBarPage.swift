import UIKit

enum TabBarPage: CaseIterable, Identifiable {
    var id: Self { self }
    
    case fridge
    case analysis
    case shopping
    case egg
    case settings
    
    var icon: ImageResource {
        switch self {
            case .fridge:
                    .Images.Icons.fridge
            case .analysis:
                    .Images.Icons.analysis
            case .shopping:
                    .Images.Icons.shopping
            case .egg:
                    .Images.Icons.egg
            case .settings:
                    .Images.Icons.settings
        }
    }
}

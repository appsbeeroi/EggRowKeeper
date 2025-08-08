import RealmSwift

enum MeasurementSystem: String, Identifiable, CaseIterable, PersistableEnum {
    var id: Self { self }
    
    case kg = "Kilograms (KG)"
    case l = "Liters (L)"
    case pcs = "Pieces"
    
    var shortName: String {
        switch self {
            case .kg:
                return "kg"
            case .l:
                return "L"
            case .pcs:
                return "pcs"
        }
    }
}

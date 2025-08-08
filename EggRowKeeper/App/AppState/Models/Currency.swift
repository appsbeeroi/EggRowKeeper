enum Currency:  String, Identifiable, CaseIterable {
    var id: Self { self }
    
    case usd = "USD"
    case eur = "EUR"
    case rub = "RUB"
    case gbp = "GBP"
    case cny = "CNY"
    case uah = "UAH"
    case brl = "BRL"
    case inr = "INR"
    
    var symbol: String {
        switch self {
            case .usd:
                return "$"
            case .eur:
                return "€"
            case .rub:
                return "₽"
            case .gbp:
                return "£"
            case .cny:
                return "¥"
            case .uah:
                return "₴"
            case .brl:
                return "R$"
            case .inr:
                return "₹" 
        }
    }
}

import SwiftUI

struct ExpenseChartView: View {
    
    let products: [FridgeProduct]
    
    private var groupedByCategory: [ProductCategoryType: [FridgeProduct]] {
        Dictionary(grouping: products) { $0.productType.parentCategory ?? .other }
    }
    
    private var totalSpent: Double {
        products
            .compactMap { Double($0.price.replacingOccurrences(of: ",", with: ".")) }
            .reduce(0, +)
    }
    
    private var categoryExpenses: [(category: ProductCategoryType, percentage: Double, total: Double)] {
        groupedByCategory.map { category, items in
            let totalForCategory = items
                .compactMap { Double($0.price.replacingOccurrences(of: ",", with: ".")) }
                .reduce(0, +)
            let percentage = totalSpent > 0 ? (totalForCategory / totalSpent) * 100 : 0
            return (category, percentage, totalForCategory)
        }
        .sorted { $0.percentage > $1.percentage }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 16) {
                Text("Overall Content Value")
                    .font(.luckiest(size: 14))
                    .foregroundStyle(.baseWhite)
                
                Text(totalSpent.formatted() + AppState.shared.currency.symbol)
                    .font(.luckiest(size: 50))
                    .foregroundStyle(LinearGradient.baseGradinent)
            }
            
            VStack(spacing: 0) {
                HStack {
                    Text("Expense categories")
                        .font(.luckiest(size: 12))
                        .foregroundStyle(.baseWhite)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                GeometryReader { geo in
                    HStack(alignment: .bottom, spacing: 16) {
                        ForEach(categoryExpenses, id: \.category) { item in
                            VStack(spacing: 10) {
                                Text("\(item.percentage, specifier: "%.0f")%")
                                    .font(.luckiest(size: 20))
                                    .foregroundStyle(.baseWhite)
                                    .fixedSize(horizontal: true, vertical: false)
                                
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.baseWhite, .baseOrange, .baseYellow],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 19, height: CGFloat(item.percentage / 100) * geo.size.height * 0.8)
                                    .cornerRadius(20)
                                
                                Text(item.category.title)
                                    .font(.luckiest(size: 9))
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.baseWhite)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.9)
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            .frame(width: 40)
                        }
                        
                        Spacer() 
                    }
                    .frame(maxWidth: .infinity, maxHeight: geo.size.height * 1.05, alignment: .bottom)
                }
                .frame(height: UIScreen.isSE ? 150 : 250)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 33)
        .background(Color.baseBlue)
        .cornerRadius(18)
        .padding(.top, 20)
        .animation(.default, value: products)
        .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
        .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
    }
}

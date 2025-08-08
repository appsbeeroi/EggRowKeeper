import SwiftUI
import SwipeActions

struct FridgeCategoryDetailCellView: View {
    
    var product: FridgeProduct
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            VStack {
                Text(product.productType.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.luckiest(size: 25))
                    .foregroundStyle(LinearGradient.baseGradinent)
                
                HStack(spacing: 12) {
                    ForEach(FridgeCategoryDetailCellVStackInfoType.allCases) { type in
                        FridgeCategoryDetailCellVStackView(product: product, infoType: type)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(17)
            .background(.baseBlue)
            .cornerRadius(18)
            .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
            .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
        } trailingActions: { context in
            Button {
                editAction()
            } label: {
                Circle()
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.baseLightBlue)
                    .overlay {
                        Image(systemName: "pencil")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
            
            Button {
                context.state.wrappedValue = .closed
                removeAction()
            } label: {
                Circle()
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.baseRed)
                    .overlay {
                        Image(systemName: "trash")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
        }
        .swipeMinimumDistance(30)
        .swipeActionWidth(50)
    }
}

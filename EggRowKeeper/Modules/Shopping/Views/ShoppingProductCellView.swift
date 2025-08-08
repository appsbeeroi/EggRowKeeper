import SwiftUI
import SwipeActions

struct ShoppingProductCellView: View {
    
    let product: FridgeProduct
    let purchase: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            VStack(spacing: 8) {
                HStack {
                    Text(product.productType.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .font(.luckiest(size: 25))
                        .foregroundStyle(LinearGradient.baseGradinent)
                    
                    HStack(spacing: 0) {
                        if let icon = product.productType.parentCategory?.smallIcon {
                            Image(icon)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                            
                            Text(product.productType.parentCategory?.title ?? "")
                                .font(.luckiest(size: 11))
                                .foregroundStyle(.baseWhite)
                        }
                    }
                    .frame(width: 67, height: 40)
                    .cornerRadius(8)
                    .background(
                        LinearGradient(
                            colors: [.baseBlue, .baseLightBlue, .baseBlue],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.black, lineWidth: 1)
                    }
                }
                .frame(height: 40)
                
                HStack(spacing: 7) {
                    HStack(spacing: 2) {
                        Text("Quantity")
                        Text(product.selectedMeasurement?.shortName ?? "")
                    }
                    .font(.luckiest(size: 11))
                    .foregroundStyle(.baseWhite.opacity(0.5))
                    
                    Text(product.quantity)
                        .font(.luckiest(size: 11))
                        .foregroundStyle(.baseWhite)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    BaseButton(title: "Purchased", height: 40, fontSize: 14) {
                        purchase()
                    }
                    .frame(width: 94)
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
    }
}

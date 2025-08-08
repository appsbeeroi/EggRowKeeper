import SwiftUI

struct MainFridgeProductCellView: View {
    
    let product: FridgeProduct
    let navigationAction: () -> Void
    
    var body: some View {
        Button {
            navigationAction()
        } label: {
            Image(uiImage: product.rightImage)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .cornerRadius(50)
                .clipped()
                .overlay {
                    Circle()
                        .frame(width: 17, height: 17)
                        .foregroundStyle(product.isExprired ? Color.red : Color.green)
                        .offset(x: 20, y: 20)
                }
        }
    }
}

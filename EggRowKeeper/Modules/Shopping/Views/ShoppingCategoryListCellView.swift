import SwiftUI

struct ShoppingCategoryListCellView: View {
    
    let category: ProductCategoryType
    
    @Binding var selectedCategory: ProductCategoryType?
    
    var body: some View {
        Button {
            selectedCategory = selectedCategory == category ? nil : category
        } label: {
            ZStack {
                if selectedCategory == category {
                    LinearGradient(
                        colors: [
                            .baseLightBlue,
                            .baseLightIndigo,
                            .baseLightBlue
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                } else {
                    Color.baseBlue
                }
                
                HStack {
                    Image(category.smallIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24)
                    
                    ZStack {
                        ZStack {
                            Text(category.title).offset(x:  0, y:  1)
                            Text(category.title).offset(x: 0, y: 2)
                            Text(category.title).offset(x: 0, y:  3)
                            Text(category.title).offset(x:  0, y: 4)
                        }
                        .foregroundColor(.baseDarkBlue)
                        .font(.luckiest(size: 12))
                        
                        Text(category.title)
                            .font(.luckiest(size: 12))
                            .foregroundStyle(.baseWhite)
                    }
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 40)
            .cornerRadius(15)
            .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
            .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
            .overlay {
                if selectedCategory == category {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.baseWhite, lineWidth: 3)
                }
            }
        }
    }
}

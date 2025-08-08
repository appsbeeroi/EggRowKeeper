import SwiftUI

struct FridgeProductCellView: View {
    
    let type: ProductType
    
    @Binding var selectedProductType: ProductType?
    
    var baseGradient: LinearGradient {
        LinearGradient(
            colors: [
                .baseDarkBlue,
                .baseBlue,
                .baseLightBlue,
                .baseDarkBlue
                
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var selectedGradient: LinearGradient {
        LinearGradient(
            colors: [
                .selectedBlue,
                .selectedLightBlue,
                .selectedBlue
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        Button {
            selectedProductType = type
        } label: {
            VStack {
                if let icon = type.icon {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
                
                HStack {
                    Text(type.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.luckiest(size: 11))
                        .foregroundStyle(.baseWhite)
                        .lineLimit(1)
                    
                    Circle()
                        .frame(width: 21, height: 21)
                        .foregroundStyle(.baseLightBlue)
                        .overlay {
                            Image(systemName: "plus")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                        }
                }
            }
            .frame(height: 122)
            .padding(4)
            .background(type == selectedProductType ? selectedGradient : baseGradient)
            .cornerRadius(13)
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(
                        type == selectedProductType ? .baseWhite : .baseDarkBlue,
                        lineWidth: type == selectedProductType ? 3 : 1
                    )
            }
        }
    }
}

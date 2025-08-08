import SwiftUI

struct AddFridgeProductView: View {
    
    @ObservedObject var viewModel: FridgeViewModel
    
    let type: ProductCategoryType
    
    @Binding var isActiveNavigation: Bool
    
    @State private var selectedProductType: ProductType?
    @State private var selectedOtherProductImage: UIImage?
    @State private var selectedProductToEdit: FridgeProduct?
    
    @State private var isShowAddFridgeProductDetailView = false
    @State private var isShowImagePicker = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    BaseBackButton()
                    
                    Text("ADD A PRODUCT")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                }
                .padding(.horizontal, 35)
                
                    VStack(spacing: 19) {
                        Image(type.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .overlay(alignment: .leading) {
                                if let selectedProductType,
                                   let icon = selectedProductType.icon {
                                    Image(icon)
                                        .resizable()
                                        .scaledToFill()
                                        .padding(.leading, 10)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(50)
                                }
                            }
                        
                        VStack(spacing: 19) {
                            HStack {
                                BaseButton(title: "OTHER PRODUCTS", height: 40, fontSize: 14) {
                                    isShowImagePicker.toggle()
                                }
                                .frame(width: 134)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 3), spacing: 10) {
                                    ForEach(type.products) { type in
                                        FridgeProductCellView(type: type, selectedProductType: $selectedProductType)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 35)
                    }
                    .padding(.top, UIScreen.isSE ? 10 : 32)
                
                Spacer()
                
                BaseButton(title: "SAVE", isActive: selectedProductType != nil) {
                    isShowAddFridgeProductDetailView.toggle()
                }
                .padding(.bottom, 24)
                .padding(.horizontal, 35)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            NavigationLink(isActive: $isShowAddFridgeProductDetailView) {
                AddFridgeProductDetailView(
                    viewModel: viewModel,
                    productType: selectedProductType ?? .other,
                    otherProductImage: selectedOtherProductImage,
                    isActiveNavigation: $isActiveNavigation
                )
            } label: {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $selectedOtherProductImage)
        }
        .onChange(of: selectedOtherProductImage) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isShowAddFridgeProductDetailView.toggle()   
            }
        }
    }
}

#Preview {
    NavigationView {
        AddFridgeProductView(
            viewModel: FridgeViewModel(realmService: DatabaseService()),
            type: .dairy,
            isActiveNavigation: .constant(false)
        )
    }
}
    

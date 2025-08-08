import SwiftUI
import SwiftUIIntrospect

struct AddShoppingListView: View {
    
    @ObservedObject var viewModel: ShoppingViewModel
    
    var isEggsRequired: Bool
    
    @Binding var isActiveNavigation: Bool
    
    @State private var selectedCategory: ProductCategoryType? = .dairy
    @State private var selectedProductType: ProductType?
    @State private var selectedOtherProductImage: UIImage?
    
    @State private var isShowImagePicker = false
    @State private var isShowFinalPage = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: 0) {
                navigationSection
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(ProductCategoryType.allCases) { type in
                                ShoppingCategoryListCellView(
                                    category: type,
                                    selectedCategory: $selectedCategory)
                                .id(type.rawValue)
                            }
                        }
                        .frame(height: 50)
                        .padding(.top, 24)
                    }
                    .highPriorityGesture(DragGesture())
                    .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { scrollView in
                        scrollView.bounces = false
                    }
                    .onAppear {
                        if isEggsRequired {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    proxy.scrollTo(4)
                                }
                            }
                        }
                    }
                }
                
                HStack {
                    BaseButton(title: "Other product", height: 40, fontSize: 14) {
                        isShowImagePicker.toggle()
                    }
                    .frame(width: 132)
                    .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 3), spacing: 10) {
                        if let selectedCategory {
                            ForEach(selectedCategory.products) { type in
                                FridgeProductCellView(type: type, selectedProductType: $selectedProductType)
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                BaseButton(title: "Next", isActive: selectedProductType != nil) {
                    isShowFinalPage = true
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
            .padding(.bottom, UIScreen.isSE ? 10 : 0)
            
            if isShowFinalPage {
                AddShoppingListFinalPage(
                    productType: selectedProductType ?? .other,
                    otherImage: selectedOtherProductImage) { rawProduct in
                        viewModel.save(rawProduct)
                    } dismiss: {
                        isShowFinalPage = false
                    }
                    .ignoresSafeArea()
                    .offset(y: UIScreen.isSE ? -10 : 0)
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.default, value: isShowFinalPage)
        .onAppear {
            selectedCategory = isEggsRequired ? .eggs : selectedCategory
        }
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $selectedOtherProductImage)
        }
        .onChange(of: selectedOtherProductImage) { _ in
            selectedProductType = .other
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isShowFinalPage = true
            }
        }
        .onChange(of: selectedCategory) { category in
            if category == nil {
                selectedProductType = nil
            }
        }
        .onChange(of: viewModel.objectWasSaved) { wasSaved in
            if wasSaved {
                viewModel.completeSavingAction()
                isActiveNavigation = false 
            }
        }
    }
    
    private var navigationSection: some View {
        ZStack {
            HStack {
                BaseBackButton()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Add to\nShopping List")
                .font(.luckiest(size: 35))
                .foregroundStyle(LinearGradient.baseGradinent)
                .multilineTextAlignment(.center)
                .offset(x: UIScreen.isSE ? 10 : 0)
        }
    }
}

#Preview {
    AddShoppingListView(
        viewModel: ShoppingViewModel(
            realmService: DatabaseService()),
        isEggsRequired: true,
        isActiveNavigation: .constant(false)
    )
}

import SwiftUI
import SwiftUIIntrospect

struct FridgeView: View {
    
    @StateObject var viewModel: FridgeViewModel
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedNewProductType: ProductCategoryType?
    @State private var selectedProductToEdit: FridgeProduct?
    @State private var isShowProductTypeList = false
    @State private var isShowAddProductView = false
    @State private var isShowDetailView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .cropAndResize()
                
                VStack(spacing: UIScreen.isSE ? 0 : 10) {
                    Text("MY FRIDGE")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                    
                    VStack(spacing: UIScreen.isSE ? 0 : 10) {
                        Image(.Images.Fridge.fridge)
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .overlay {
                                productList
                            }
                        
                        BaseButton(title: "Add a product", height: UIScreen.isSE ? 35 : 55) {
                            isShowProductTypeList.toggle()
                        }
                        .padding(.horizontal, 35)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 60)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                NavigationLink(isActive: $isShowAddProductView) {
                    AddFridgeProductView(
                        viewModel: viewModel,
                        type: selectedNewProductType ?? .dairy,
                        isActiveNavigation: $isShowAddProductView
                    )
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $isShowDetailView) {
                    FridgeCategoryDetail(viewModel: viewModel, product: selectedProductToEdit, isActiveNavigation: $isShowDetailView)
                } label: {
                    EmptyView()
                }
            }
            .ignoresSafeArea(edges: [.horizontal])
            .onAppear {
                isShowTabBar = true
                viewModel.loadProducts()
            }
            .confirmationDialog("Select product type", isPresented: $isShowProductTypeList) {
                ForEach(ProductCategoryType.allCases) { type in
                    Button(type.title) {
                        selectedNewProductType = type
                        isShowTabBar = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isShowAddProductView.toggle()
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
    
    private var productList: some View {
        VStack(spacing: UIScreen.isSE ? -15 : 0) {
            ForEach(ProductCategoryType.allCases) { category in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        let source = viewModel.products.filter { $0.productType.parentCategory == category }
                        
                        Color.clear
                            .frame(width: 10, height: 100)
                        
                        ForEach(source) { product in
                            MainFridgeProductCellView(product: product) {
                                selectedProductToEdit = product
                                isShowTabBar = false
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isShowDetailView.toggle()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .highPriorityGesture(DragGesture())
                .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { scrollView in
                    scrollView.bounces = false
                }
            }
        }
        .padding(.top, UIScreen.isSE ? 0 : -30)
        .offset(y: UIScreen.isSE ? -15 : 0)
        .padding(.leading, 15)
    }
}

#Preview {
    FridgeView(
        viewModel: FridgeViewModel(realmService: DatabaseService()),
        isShowTabBar: .constant(false)
    )
}



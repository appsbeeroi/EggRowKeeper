import SwiftUI
import SwiftUIIntrospect

struct ShoppingView: View {
    
    @StateObject var viewModel: ShoppingViewModel
    
    @Binding var isShowTabBar: Bool
    
    @State private var isShowAddToShoppingListView = false
    @State private var isEggsRequired = false
    @State private var isShowEggView = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .cropAndResize()
                
                VStack(spacing: 0) {
                    Text("Shopping List")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                    
                    VStack(spacing: 12) {
                        if !viewModel.defaultProducts.contains(where: { $0.productType == .eggs }) && isShowEggView {
                            ShoppingEggsAvailabilityView {
                                isEggsRequired = true
                                isShowTabBar = false
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isShowAddToShoppingListView.toggle()
                                }
                            } cancelAction: {
                                isShowEggView = false
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 6) {
                                ForEach(ProductCategoryType.allCases) { type in
                                    ShoppingCategoryListCellView(category: type, selectedCategory: $viewModel.selectedCategory)
                                }
                            }
                            .frame(height: 50)
                        }
                        .padding(.top, 10)
                        .highPriorityGesture(DragGesture())
                        .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { scrollView in
                            scrollView.bounces = false
                        }
                        
                        let source = viewModel.products.filter { !$0.isPurchased }
                        
                        ScrollView(showsIndicators: false) {
                            ForEach(source) { product in
                                ShoppingProductCellView(product: product) {
                                    viewModel.purchase(product)
                                } removeAction: {
                                    viewModel.remove(product)
                                }
                            }
                        }
                        
                        BaseButton(title: "Add to Shopping List") {
                            isShowTabBar = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isShowAddToShoppingListView.toggle()
                            }
                        }
                    }
                    .padding(.top, UIScreen.isSE ? 10 : 20)
                    .padding(.horizontal, 35)
                    .padding(.bottom, UIScreen.isSE ? 70 : 60)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                NavigationLink(isActive: $isShowAddToShoppingListView) {
                    AddShoppingListView(viewModel: viewModel, isEggsRequired: isEggsRequired, isActiveNavigation: $isShowAddToShoppingListView)
                } label: {
                    EmptyView()
                }
            }
            .animation(.default, value: isShowEggView)
            .onAppear {
                isShowTabBar = true
                viewModel.loadProducts()
            }
            .onDisappear {
                isEggsRequired = false
            }
            .alert("Product was purchased", isPresented: $viewModel.isShowPurchaseAlert) {
                Button("Ok") {}
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    NavigationView {
        ShoppingView(
            viewModel: ShoppingViewModel(
                realmService: DatabaseService()
            ),
            isShowTabBar: .constant(false)
        )
    }
}


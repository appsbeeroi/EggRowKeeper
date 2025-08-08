import SwiftUI

struct FridgeCategoryDetail: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: FridgeViewModel
    
    var product: FridgeProduct?
    
    @Binding var isActiveNavigation: Bool
    
    @State private var source: [FridgeProduct]
    @State private var productToEdit: FridgeProduct?
    
    @State private var isShowDeleteCategoryButton = false
    @State private var isShowEditView = false
    
    init(viewModel: FridgeViewModel, product: FridgeProduct?, isActiveNavigation: Binding<Bool>) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.product = product
        self._isActiveNavigation = isActiveNavigation
        
        source = viewModel.products
            .filter { $0.productType.parentCategory == product?.productType.parentCategory }
    }
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    BaseBackButton()
                    
                    Spacer()
                    
                    deleteCategoryButton
                }
                .padding(.horizontal, 35)
                
                VStack(spacing: 0) {
                    if let icon = product?.productType.parentCategory?.icon {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .overlay(alignment: .leading) {
                                productList
                            }
                    }
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(source) { product in
                                FridgeCategoryDetailCellView(product: product) {
                                    productToEdit = product
                                    isShowEditView = true
                                } removeAction: {
                                    viewModel.remove(product)
                                }
                            }
                        }
                    }
                    .padding(.top, 32)
                    .padding(.horizontal, 35)
                    .padding(.bottom, 24)
                    
                    BaseButton(title: "Save") {
                        dismiss()
                    }
                    .padding(.horizontal, 35)
                }
                .padding(.top, 32)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            NavigationLink(isActive: $isShowEditView) {
                AddFridgeProductDetailView(
                    viewModel: viewModel,
                    productType: product?.productType ?? .other,
                    fridgeProductToEdit: productToEdit,
                    isActiveNavigation: $isActiveNavigation)
            } label: {
                EmptyView()
            }

        }
        .navigationBarBackButtonHidden()
        .animation(.default, value: source)
        .alert("Delete the whole category?", isPresented: $isShowDeleteCategoryButton) {
            Button("No", role: .cancel) {}
            Button("Yes", role: .destructive) {
                guard let category = product?.productType.parentCategory else { return }
                viewModel.removeWhole(category)
            }
        }
        .onChange(of: viewModel.categoryWasDelete) { wasDelete in
            if wasDelete {
                viewModel.completeDeletingCategoryAction()
                dismiss()
            }
        }
        .onChange(of: viewModel.productWasDelete) { wasDelete in
            if wasDelete {
                viewModel.completeDeletingProductAction()
                setupSource()
            }
        }
    }
    
    private var deleteCategoryButton: some View {
        Button {
            isShowDeleteCategoryButton.toggle()
        } label: {
            Circle()
                .frame(width: 42, height: 42)
                .foregroundStyle(.baseRed)
                .overlay {
                    Image(systemName: "trash")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.baseWhite)
                }
        }
    }
    
    private var productList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Color.clear
                    .frame(width: 10, height: 100)
                
                ForEach(source) { product in
                    MainFridgeProductCellView(product: product) {}
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.remove(product)
                            } label: {
                                Label("Remove", systemImage: "trash")
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 15)
        .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { scrollView in
            scrollView.bounces = false
        }
    }
    
    private func setupSource() {
        source = viewModel.products
            .filter { $0.productType.parentCategory == product?.productType.parentCategory }
    }
}

#Preview {
    FridgeCategoryDetail(
        viewModel: FridgeViewModel(
            realmService: DatabaseService()),
        product: FridgeProduct(),
        isActiveNavigation: .constant(false)
    )
}



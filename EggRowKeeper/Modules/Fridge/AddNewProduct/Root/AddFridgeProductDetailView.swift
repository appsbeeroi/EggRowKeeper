import SwiftUI

struct AddFridgeProductDetailView: View {
    
    @ObservedObject var viewModel: FridgeViewModel
    
    let productType: ProductType
    var otherProductImage: UIImage?
    var fridgeProductToEdit: FridgeProduct?
    
    @Binding var isActiveNavigation: Bool
    
    @State private var rawProduct = RawFridgeProduct(isPurchased: true)
    @State private var currentDate = Date()
    @State private var currentActiveType: AddNewFridgeProductTextFieldType?
    @State private var isShowDatePicker = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
                .onTapGesture {
                    isShowDatePicker = false
                }
            
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    BaseBackButton()
                    
                    Text("ADD A PRODUCT")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                }
                .padding(.horizontal, 35)
                
                VStack(spacing: 0) {
                    if let icon = productType.parentCategory?.icon {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .overlay(alignment: .leading) {
                                if let icon = productType.icon {
                                    Image(icon)
                                        .resizable()
                                        .scaledToFill()
                                        .padding(.leading, 10)
                                        .frame(width: 80, height: 80)
                                        .offset(y: UIScreen.isSE ? -20 : 0)
                                } else if let image = otherProductImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(50)
                                        .clipped()
                                        .padding(.leading, 25)
                                        .offset(y: UIScreen.isSE ? -20 : 0)
                                }
                            }
                    }
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 10) {
                            AddNewFridgeProductTextField(
                                type: .quantity,
                                text: $rawProduct.quantity,
                                activeType: $currentActiveType,
                                isFocused: $isFocused
                            )
                            
                            AddNewFridgeProductDateView(
                                type: .purchaseDate,
                                date: $rawProduct.purchaseDate,
                                activeType: $currentActiveType,
                                isShowDatePicker: $isShowDatePicker
                            )
                            
                            AddNewFridgeProductDateView(
                                type: .expirationDate,
                                date: $rawProduct.expirationDate,
                                activeType: $currentActiveType,
                                isShowDatePicker: $isShowDatePicker
                            )
                            
                            AddNewFridgeProductTextField(
                                type: .price,
                                text: $rawProduct.price,
                                activeType: $currentActiveType,
                                isFocused: $isFocused
                            )
                        }
                        
                        HStack(spacing: 10) {
                            ForEach(MeasurementSystem.allCases) { system in
                                AddNewFridgeProductMeasureButton(
                                    system: system,
                                    selectedMeasurement: $rawProduct.selectedMeasurement
                                )
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                        
                        Spacer()
                        
                        BaseButton(title: "Save", isActive: rawProduct.isEnableToSave) {
                            viewModel.save(rawProduct)
                        }
                    }
                    .padding(.top, 35)
                    .padding(.horizontal, 35)
                    .padding(.bottom, UIScreen.isSE ? 10 : 0)
                }
                .padding(.top, 32)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            DatePicker("", selection: $currentDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.graphical)
                .background(
                    Color.baseWhite
                        .padding(-20)
                        .cornerRadius(20)
                )
                .padding()
                .opacity(isShowDatePicker ? 1 : 0)
                .animation(.default, value: isShowDatePicker)
            
            if viewModel.objectWasSaved {
                SuccessfulSavingActionAlertView {
                    viewModel.completeSavingAction()
                    isActiveNavigation = false
                }
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.default, value: viewModel.objectWasSaved)
        .onAppear {
            if let image = otherProductImage{
                rawProduct.image = image
            } else if let icon = productType.icon {
                let productImage = UIImage(resource: icon)
                rawProduct.image = productImage
            }
            
            rawProduct.productType = productType
            updateRawProductIfRequired()
        }
        .onChange(of: currentDate) { date in
            guard currentActiveType == .expirationDate || currentActiveType == .purchaseDate else { return }
            currentActiveType == .expirationDate ?
            (rawProduct.expirationDate = date) :
            (rawProduct.purchaseDate = date)
            currentActiveType = nil
            isShowDatePicker = false
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button("Done") {
                        isFocused = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    private func updateRawProductIfRequired() {
        if let fridgeProductToEdit {
            rawProduct.update(by: fridgeProductToEdit)
        }
    }
}

#Preview {
    AddFridgeProductDetailView(
        viewModel: FridgeViewModel(realmService: DatabaseService()),
        productType: .apple,
        otherProductImage: nil,
        isActiveNavigation: .constant(
            false
        )
    )
    .environmentObject(FridgeViewModel(realmService: DatabaseService()))
}



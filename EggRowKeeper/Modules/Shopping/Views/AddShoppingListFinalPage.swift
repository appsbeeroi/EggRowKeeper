import SwiftUI

struct AddShoppingListFinalPage: View {
    
    let productType: ProductType
    var otherImage: UIImage?
    let saveAction: (RawFridgeProduct) -> Void
    let dismiss: () -> Void
        
    @State private var rawProduct = RawFridgeProduct(isPurchased: false)
    @State private var currentDate = Date()
    @State private var currentActiveType: AddNewFridgeProductTextFieldType?
    
    @State private var isShowDatePicker = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
            
            VStack(spacing: 20) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.baseRed)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Adding food to the refrigerator")
                    .font(.luckiest(size: 30))
                    .foregroundStyle(LinearGradient.baseGradinent)
                    .multilineTextAlignment(.center)
                
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
                    
                    HStack(spacing: 10) {
                        ForEach(MeasurementSystem.allCases) { system in
                            AddNewFridgeProductMeasureButton(
                                system: system,
                                selectedMeasurement: $rawProduct.selectedMeasurement
                            )
                        }
                    }
                }
                
                BaseButton(title: "Save", isActive: rawProduct.isEnableToSave) {
                    saveAction(rawProduct)
                }
            }
            .padding(17)
            .background(.baseDarkBlue)
            .cornerRadius(18)
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.baseLightBlue, lineWidth: 1)
            }
            .padding(.horizontal, 30)
            
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
        .onAppear {
            rawProduct.productType = productType
            
            if let image = otherImage {
                rawProduct.image = image
            } else if let icon = productType.icon {
                rawProduct.image = UIImage(resource: icon)
            }
        }
        .onChange(of: currentDate) { date in
            guard currentActiveType == .expirationDate || currentActiveType == .purchaseDate else { return }
            currentActiveType == .expirationDate ?
            (rawProduct.expirationDate = date) :
            (rawProduct.purchaseDate = date)
            currentActiveType = nil
            isShowDatePicker = false
        }
    }
}

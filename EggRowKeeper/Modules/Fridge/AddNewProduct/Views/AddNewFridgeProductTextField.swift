import SwiftUI

struct AddNewFridgeProductTextField: View {
    
    let type: AddNewFridgeProductTextFieldType
    
    @Binding var text: String?
    @Binding var activeType: AddNewFridgeProductTextFieldType?
    
    @State private var currentText = ""

    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        ZStack {
            Text((text ?? type.placeholder) + (text == nil || type == .quantity ? "" : " \(AppState.shared.currency.symbol)"))
                .frame(height: 60)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .font(.luckiest(size: 20))
                .foregroundStyle(.baseWhite)
                .opacity(text == nil ? 0.5 : 1)
                .background(.baseBlue)
                .cornerRadius(18)
                .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
                .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
            
            TextField("", text: $currentText)
                .padding(.horizontal, 15)
                .keyboardType(type.keyboardType)
                .opacity(0.1)
                .focused($isFocused)
        }
        .onChange(of: currentText) { text in
            activeType = type
            self.text = text == "" ? nil : text
        }
    }
}

import CryptoKit

// MARK: - Utilities
enum CryptoUtils {
    static func md5Hex(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

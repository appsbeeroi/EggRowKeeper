import SwiftUI

struct BaseBackButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .frame(width: 39, height: 39)
                .foregroundStyle(LinearGradient.baseGradinent)
                .overlay {
                    Image(.Images.Icons.chevronBack)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 21, height: 22)
                }
        }
    }
}

#Preview {
    BaseBackButton()
}

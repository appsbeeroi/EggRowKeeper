import SwiftUI

struct SuccessfulSavingActionAlertView: View {
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.4)
            
            VStack(spacing: 20) {
                VStack(spacing: 30) {
                    HStack {
                        Button {
                            action()
                        } label: {
                            Image(systemName: "multiply")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundStyle(.baseRed)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("Product added to refrigerator")
                        .font(.luckiest(size: 30))
                        .foregroundStyle(LinearGradient.baseGradinent)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 14)
                .padding(.trailing, 14)
                .padding(.bottom, 50)
                .background(.baseBlue)
                .cornerRadius(18)
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.baseLightBlue, lineWidth: 1)
                }
                
                BaseButton(title: "Ok", action: action)
            }
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    SuccessfulSavingActionAlertView() {}
        .padding()
    
}

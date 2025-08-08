import SwiftUI

struct CurrencySelectionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedCurrency: Currency
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: 35) {
                ZStack {
                    HStack(spacing: 10) {
                        BaseBackButton()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Currency")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 3), spacing: 10) {
                    ForEach(Currency.allCases) { currency in
                        Button {
                            selectedCurrency = currency
                        } label: {
                            ZStack {
                                if selectedCurrency == currency {
                                    LinearGradient(
                                        colors: [
                                            .baseLightBlue,
                                            .baseLightIndigo,
                                            .baseLightBlue
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                } else {
                                    Color.baseBlue
                                }
                                
                                ZStack {
                                    Text(currency.rawValue).offset(x:  0, y:  1)
                                    Text(currency.rawValue).offset(x: 0, y: 2)
                                    Text(currency.rawValue).offset(x: 0, y:  3)
                                    Text(currency.rawValue).offset(x:  0, y: 4)
                                }
                                .foregroundColor(.baseDarkBlue)
                                
                                Text(currency.rawValue)
                                    .font(.luckiest(size: 18))
                                    .foregroundStyle(.baseWhite)
                            }
                            .frame(height: 40)
                            .cornerRadius(15)
                            .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
                            .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
                            .overlay {
                                if selectedCurrency == currency {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.baseWhite, lineWidth: 3)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
        }
        .navigationBarBackButtonHidden()
    }
}

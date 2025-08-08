import SwiftUI

struct AnalysisView: View {
    
    @StateObject var viewModel: AnalysisViewModel
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: 0) {
                Text("Refrigerator\nanalysis")
                    .font(.luckiest(size: 35))
                    .foregroundStyle(LinearGradient.baseGradinent)
                    .multilineTextAlignment(.center)
                
                if !viewModel.products.isEmpty {
                    VStack(spacing: 10) {
                        ExpenseChartView(products: viewModel.products)
                        MostPurchasedView(products: viewModel.products)
                    }
                    .padding(.top, UIScreen.isSE ? 10 : 20)
                    .padding(.horizontal, 35)
                    .transition(.opacity)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if viewModel.products.isEmpty {
                stumb
            }
        }
        .animation(.default, value: viewModel.products)
        .onAppear {
            viewModel.loadProducts()
        }
    }
    
    private var stumb: some View {
        VStack(spacing: 30) {
            Image(systemName: "multiply")
                .font(.system(size: 150, weight: .bold))
                .foregroundStyle(.red)
            
            Text("There's nothing here\nyet..")
                .font(.luckiest(size: 25))
                .foregroundStyle(LinearGradient.baseGradinent)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    AnalysisView(viewModel: AnalysisViewModel(realmService: DatabaseService()))
}


import SwiftUI

struct MeasurementSelectionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: 35) {
                HStack(spacing: 10) {
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
                    
                    Text("Measurement")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(
                            .flexible(minimum: 130, maximum: 160),
                            spacing: 10,
                            alignment: .leading),
                        count: 2), spacing: 10) {
                            ForEach(MeasurementSystem.allCases) { system in
                                MeasurementCellView(system: system)
                            }
                        }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
        }
        .navigationBarBackButtonHidden()
    }
}

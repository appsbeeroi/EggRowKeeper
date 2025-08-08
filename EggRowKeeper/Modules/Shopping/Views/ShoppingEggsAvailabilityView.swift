import SwiftUI

struct ShoppingEggsAvailabilityView: View {
    
    let navigationAction: () -> Void
    let cancelAction: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(spacing: 2) {
                    Text("❗️ NO EGGS")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.luckiest(size: 20))
                        .foregroundStyle(.baseWhite)
                    
                    Text("Add to shopping?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.luckiest(size: 11))
                        .foregroundStyle(.baseWhite.opacity(0.5))
                }
                
                Text("EGGS")
                    .frame(height: 26)
                    .frame(width: 58)
                    .font(.luckiest(size: 12))
                    .foregroundStyle(.baseWhite)
                    .cornerRadius(300)
                    .overlay {
                        RoundedRectangle(cornerRadius: 300)
                            .stroke(.baseWhite, lineWidth: 1)
                    }
            }
            
            HStack(spacing: 8) {
                Button {
                    navigationAction()
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.baseWhite, lineWidth: 3)
                        .frame(width: 48, height: 30)
                        .background(.baseLightBlue)
                        .cornerRadius(8)
                        .overlay {
                            Image(systemName: "plus")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.baseWhite)
                        }
                }
                
                Button {
                    cancelAction()
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.baseWhite, lineWidth: 3)
                        .frame(width: 48, height: 30)
                        .background(.baseRed)
                        .cornerRadius(8)
                        .overlay {
                            Image(systemName: "multiply")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.baseWhite)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(17)
        .background(.baseBlue)
        .cornerRadius(18)
        .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
        .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
    }
}

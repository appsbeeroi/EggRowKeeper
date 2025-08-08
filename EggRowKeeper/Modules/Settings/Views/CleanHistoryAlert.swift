import SwiftUI

struct CleanHistoryAlert: View {
    
    @Binding var isPresented: Bool
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("DELETE")
                .font(.luckiest(size: 45))
                .foregroundStyle(LinearGradient.baseGradinent)
            
            Text("History cleaning and data reset is an irreversible action")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 6) {
                Button {
                    isPresented = false
                } label: {
                    ZStack {
                        LinearGradient(
                            colors: [
                                .baseLightBlue,
                                .baseLightIndigo,
                                .baseLightBlue
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        ZStack {
                            Text("Cancel").offset(x:  1, y:  1)
                            Text("Cancel").offset(x: -1, y: -1)
                            Text("Cancel").offset(x: -1, y:  1)
                            Text("Cancel").offset(x:  1, y: -1)
                        }
                        .foregroundColor(.baseDarkRed)
                        
                        Text("Cancel")
                    }
                    .frame(height: 55)
                    .font(.luckiest(size: 20))
                    .foregroundColor(.baseWhite)
                    .cornerRadius(15)
                }
                
                Button {
                    action()
                    isPresented = false 
                } label: {
                    ZStack {
                        LinearGradient(
                            colors: [
                                .baseRed,
                                .baseLightRed,
                                .baseRed
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        ZStack {
                            Text("Delete").offset(x:  1, y:  1)
                            Text("Delete").offset(x: -1, y: -1)
                            Text("Delete").offset(x: -1, y:  1)
                            Text("Delete").offset(x:  1, y: -1)
                        }
                        .foregroundColor(.baseDarkRed)
                        
                        Text("Delete")
                    }
                    .frame(height: 55)
                    .font(.luckiest(size: 20))
                    .foregroundColor(.baseWhite)
                    .cornerRadius(15)
                }
            }
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 33)
        .background(.baseDarkBlue)
        .cornerRadius(18)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.baseBlue, lineWidth: 1)
        }
    }
}

import SwiftUI

struct SplashScreen: View {
    
    @Binding var isShowMainFlow: Bool
    
    @State private var isAnimateText = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            Text("EGGROW\nKEEPER")
                .font(.luckiest(size: 80))
                .multilineTextAlignment(.center)
                .foregroundStyle(LinearGradient.baseGradinent)
                .shadow(color: .baseDarkRed, radius: 0, y: 4)
                .opacity(isAnimateText ? 1 : 0)
                .animation(.easeInOut(duration: 4), value: isAnimateText)
        }
        .onAppear {
            isAnimateText = true
        }
    }
}

#Preview {
    SplashScreen(isShowMainFlow: .constant(false))
}

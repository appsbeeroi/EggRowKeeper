import SwiftUI

struct EggOfTheDayView: View {
    
    @StateObject private var viewModel = EggOfTheDayViewModel()
    
    @State private var isShareImage = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .cropAndResize()
            
            VStack(spacing: UIScreen.isSE ? 10 : 16) {
                VStack {
                    Text("Egg of the day")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                    
                    VStack(spacing: 0) {
                        Image(viewModel.eggOfTheDay.icon)
                            .resizable()
                            .scaledToFit()
                        
                        Text("Eggs can remember faces —\nthey distinguish people from\nhens")
                            .font(.luckiest(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.baseWhite)
                    }
                    .padding(28)
                    .background(.baseBlue)
                    .cornerRadius(18)
                    .padding(.horizontal, 35)
                    .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
                    .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
                }
                
                HStack(spacing: 7) {
                    BaseButton(systemImage: "square.and.arrow.down") {
                        viewModel.saveEggImageToGallery()
                    }
                    
                    BaseButton(systemImage: "arrowshape.turn.up.right.fill") {
                        isShareImage.toggle()
                    }
                }
                .padding(.horizontal, 100)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .sheet(isPresented: $isShareImage) {
            let image = UIImage(resource: viewModel.eggOfTheDay.icon)
            ActivityView(activityItems: [image])
        }
        .alert("The image successfuly saved to gallery", isPresented: $viewModel.isShowSaccessSavingAlert) {}
        .alert("The gallery acces is required. Open Settings?", isPresented: $viewModel.isShowGalleryAlert) {
            Button("Cancel", role: .destructive) {}
            Button("Yes", role: .cancel) {
                UIApplication.openAppSettings()
            }
        }
    }
}

#Preview {
    EggOfTheDayView()
}

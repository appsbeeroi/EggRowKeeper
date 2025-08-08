import SwiftUI

extension Image {
    func cropAndResize() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

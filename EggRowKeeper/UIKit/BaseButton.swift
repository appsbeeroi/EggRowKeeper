import SwiftUI

struct BaseButton: View {
    
    let title: String?
    let systemImage: String?
    let height: CGFloat
    let fontSize: CGFloat
    let isActive: Bool
    let action: () -> Void
    
    init(
        title: String? = nil,
        systemImage: String? = nil,
        height: CGFloat = 55,
        fontSize: CGFloat = 22,
        isActive: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.height = height
        self.fontSize = fontSize
        self.isActive = isActive
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .foregroundStyle(LinearGradient.baseGradinent)
                .cornerRadius(15)
                .shadow(color: .baseDarkRed, radius: 0, x: 0, y: 2)
                .shadow(color: .baseDarkRed, radius: 0, x: -4, y: 4)
                .overlay {
                    if let title {
                        ZStack {
                            ZStack {
                                Text(title).offset(x:  1, y:  1)
                                Text(title).offset(x: -1, y: -1)
                                Text(title).offset(x: -1, y:  1)
                                Text(title).offset(x:  1, y: -1)
                            }
                            .foregroundColor(.baseDarkRed)
                            .lineLimit(1)
                            
                            Text(title)
                                .lineLimit(1)
                        }
                        .font(.luckiest(size: fontSize))
                        .foregroundColor(.baseWhite)
                        .shadow(color: .baseDarkRed, radius: 0, y: 4)
                    } else if let systemImage {
                        Image(systemName: systemImage)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.baseWhite)
                            .frame(width: 43, height: 43)
                    }
                }
        }
        .disabled(!isActive)
        .opacity(isActive ? 1 : 0.6)
    }
}

#Preview {
    BaseButton(title: "Continue") {}
        .padding(.horizontal)
}

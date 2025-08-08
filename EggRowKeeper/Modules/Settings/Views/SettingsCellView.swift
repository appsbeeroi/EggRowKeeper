import SwiftUI

struct SettingsCellView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    let type: SettingsCellType
    
    
    var body: some View {
        HStack {
            Text(type.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.luckiest(size: 20))
                .foregroundStyle(.baseWhite)
            
            if type.hasChevron {
                Image(systemName: "arrowtriangle.right.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.baseYellow)
            }
            
            if type == .notification {
                Toggle(isOn: $viewModel.isNotificationEnable) {}
                    .labelsHidden()
                    .tint(.baseYellow)
            }
            
            if type == .history && viewModel.hasJustHistoryCleaned {
                Text("Clear")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.luckiest(size: 20))
                    .foregroundStyle(.baseWhite)
            }
        }
        .frame(minHeight: 60)
        .padding(.horizontal, 15)
        .background(.baseBlue)
        .cornerRadius(18)
        .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
        .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
        .animation(.default, value: viewModel.hasJustHistoryCleaned)
        .onTapGesture {
            viewModel.handleAction(by: type)
        }
    }
}

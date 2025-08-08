import SwiftUI

struct MeasurementCellView: View {
    
    let system: MeasurementSystem
    let isShortName: Bool
    
    init(system: MeasurementSystem, isShortName: Bool = false) {
        self.system = system
        self.isShortName = isShortName
    }
    
    var body: some View {
        ZStack {
            Color.baseBlue
            
            ZStack {
                Text(isShortName ? system.shortName : system.rawValue).offset(x:  1, y:  1)
                Text(isShortName ? system.shortName : system.rawValue).offset(x: -1, y: -1)
                Text(isShortName ? system.shortName : system.rawValue).offset(x: -1, y:  1)
                Text(isShortName ? system.shortName : system.rawValue).offset(x:  1, y: -1)
            }
            .foregroundColor(.baseDarkBlue)
            .lineLimit(1)
            
            Text(isShortName ? system.shortName : system.rawValue)
                .font(.luckiest(size: 18))
                .foregroundStyle(.baseWhite)
                .lineLimit(1)
        }
        .frame(height: 40)
        .cornerRadius(15)
        .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
        .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
    }
}

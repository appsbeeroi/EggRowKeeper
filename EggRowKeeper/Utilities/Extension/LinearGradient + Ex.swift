import SwiftUI

extension LinearGradient {
    static var baseGradinent: LinearGradient {
        LinearGradient(colors: [.baseWhite, .baseOrange, .baseYellow], startPoint: .top, endPoint: .bottom)
    }
    
    static func simpleGradient(with color: Color) -> LinearGradient {
        LinearGradient(colors: [color], startPoint: .top, endPoint: .bottom)
    }
}

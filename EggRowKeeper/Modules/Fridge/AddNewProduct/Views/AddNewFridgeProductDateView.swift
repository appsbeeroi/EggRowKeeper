import SwiftUI

struct AddNewFridgeProductDateView: View {
    
    let type: AddNewFridgeProductTextFieldType
    
    @Binding var date: Date?

    @Binding var activeType: AddNewFridgeProductTextFieldType?
    @Binding var isShowDatePicker: Bool
    
    var body: some View {
        Text(date?.formatted(.dateTime.year().month(.twoDigits).day()) ?? type.placeholder)
            .frame(height: 60)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            .font(.luckiest(size: 20))
            .foregroundStyle(.baseWhite)
            .opacity(date == nil ? 0.5 : 1)
            .background(.baseBlue)
            .cornerRadius(18)
            .shadow(color: .baseDarkBlue, radius: 0, x: 0, y: 2)
            .shadow(color: .baseDarkBlue, radius: 0, x: -1, y: 4)
            .onTapGesture {
                activeType = type
                
                withAnimation {
                    isShowDatePicker.toggle()
                }
            }
    }
}

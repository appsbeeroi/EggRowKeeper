import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var currentPage: TabBarPage
    
    var body: some View {
        HStack {
            ForEach(TabBarPage.allCases) { page in
                Button {
                    currentPage = page
                } label: {
                    Image(page.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 39, height: 39)
                        .foregroundStyle(
                            currentPage == page ?
                            LinearGradient.baseGradinent :
                                LinearGradient.simpleGradient(with: .baseBlue)
                        )
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.isSE ? 50 : 60)
            }
        }
        .padding(.horizontal, 28)
        .background(.baseDarkBlue)
        .cornerRadius(18)
    }
}

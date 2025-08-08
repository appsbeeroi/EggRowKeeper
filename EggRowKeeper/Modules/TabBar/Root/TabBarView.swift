import SwiftUI

struct TabBarView: View {
    
    private let realmService = DatabaseService()
    
    @State private var currentPage: TabBarPage = .fridge
    @State private var isShowTabBar = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {            
            VStack {
                TabView(selection: $currentPage) {
                    FridgeView(viewModel: FridgeViewModel(
                        realmService: realmService),
                               isShowTabBar: $isShowTabBar)
                    .tag(TabBarPage.fridge)
                    .gesture(DragGesture())
                    
                    AnalysisView(viewModel: AnalysisViewModel(realmService: realmService))
                        .tag(TabBarPage.analysis)
                        .gesture(
                            DragGesture()
                        )
                    
                    ShoppingView(viewModel: ShoppingViewModel(realmService: realmService),
                                 isShowTabBar: $isShowTabBar)
                    .tag(TabBarPage.shopping)
                    .gesture(
                        DragGesture()
                    )
                    
                    EggOfTheDayView()
                        .tag(TabBarPage.egg)
                        .gesture(
                            DragGesture()
                        )
                    
                    SettingsView(viewModel: SettingsViewModel(databaseService: realmService))
                        .tag(TabBarPage.settings)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
            VStack {
                if isShowTabBar {
                    CustomTabBarView(currentPage: $currentPage)
                        .padding(.horizontal, 35)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, UIScreen.isSE ? 5 : 20)
            .animation(.default, value: isShowTabBar)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TabBarView()
}

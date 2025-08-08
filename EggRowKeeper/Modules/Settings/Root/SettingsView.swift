import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isNotificationEnable") var isNotificationEnable = true
    @AppStorage("Currency") var currency: String = "USD"
    
    @StateObject private var viewModel = SettingsViewModel()
    
    @State private var isShowNotificationAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .cropAndResize()
                
                VStack(spacing: UIScreen.isSE ? 10 : 45) {
                    Text("Settings")
                        .font(.luckiest(size: 35))
                        .foregroundStyle(LinearGradient.baseGradinent)
                    
                    VStack(spacing: 8) {
                        ForEach(SettingsCellType.allCases) { type in
                            SettingsCellView(viewModel: viewModel, type: type)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 35)
                .overlay {
                    if viewModel.isShowCleanHistoryAlert {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.black.opacity(0.4))
                                .ignoresSafeArea()
                            
                            CleanHistoryAlert(isPresented: $viewModel.isShowCleanHistoryAlert) {
                                viewModel.cleanHistory()
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                }
                
                NavigationLink(isActive: $viewModel.isShowCurrencyView) {
                    CurrencySelectionView(selectedCurrency: $viewModel.currentCurrency)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $viewModel.isShowMeasurementView) {
                    MeasurementSelectionView()
                } label: {
                    EmptyView()
                }
            }
            .animation(.default, value: viewModel.isShowCleanHistoryAlert)
            .onAppear {
                viewModel.isNotificationEnable = isNotificationEnable
            }
            .onDisappear {
                viewModel.hasJustHistoryCleaned = false
            }
            .alert("Notification permission didn't granted", isPresented: $isShowNotificationAlert) {
                Button("Yes") {
                    viewModel.openAppSettings()
                }
                
                Button("No") {
                    viewModel.isNotificationEnable = false
                }
            } message: {
                Text("Open app settings?")
            }
            .onChange(of: viewModel.isNotificationEnable) { isEnable in
                if isEnable {
                    Task {
                        switch await LocalNotificationService.shared.permissionStatus {
                            case .authorized:
                                isNotificationEnable = isEnable
                            case .denied:
                                isShowNotificationAlert = true
                            case .notDetermined:
                                LocalNotificationService.shared.requestPermission()
                        }
                    }
                }
            }
            .onChange(of: viewModel.currentCurrency) { currency in
                AppState.shared.setupCurrency(currency)
                self.currency = currency.rawValue
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    SettingsView()
}


import UIKit

final class EggOfTheDayViewModel: ObservableObject {
    
    @Published var isShowGalleryAlert = false
    @Published var isShowSaccessSavingAlert = false 
    
    @Published private(set) var eggOfTheDay: EggOfTheDayState = .cautious
    
    init() {
        setupEgg()
    }
    
    func saveEggImageToGallery() {
        PhotoAccessService.requestPhotoLibraryAccess { [weak self] granted in
            guard let self else { return }
            
            guard granted else {
                print("Access to photo library denied")
                self.isShowGalleryAlert = true 
                return
            }
            
            let uiImage = UIImage(resource: eggOfTheDay.icon)
            
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            
            isShowSaccessSavingAlert.toggle()
        }
    }
    
    
    private func setupEgg() {
        let day = Int(Date().formatted(.dateTime.day())) ?? 0
        let index = day % 3
        
        eggOfTheDay = switch index {
            case 0:
                    .cautious
            case 1:
                    .philosopher
            case 2:
                    .proud
            default:
                    .cautious
        }
    }
}

import UIKit

final class ImageStorageService {
    
    static let shared = ImageStorageService()
    
    private init() {}
    
    private let folderName = "ProductImages"

    private var imagesDirectoryURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folderURL = documentDirectory.appendingPathComponent(folderName)
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            try? FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        
        return folderURL
    }

    func saveImage(_ image: UIImage, for id: UUID) async -> String? {
        let fileName = "\(id.uuidString).png"
        let fileURL = imagesDirectoryURL.appendingPathComponent(fileName)

        guard let data = image.pngData() else {
            print("❌ Не удалось преобразовать UIImage в PNG")
            return nil
        }

        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            print("❌ Ошибка при сохранении изображения: \(error)")
            return nil
        }
    }


    func loadImage(from fileName: String) async -> UIImage? {
        let fileURL = imagesDirectoryURL.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: fileURL.path)
    }

    func deleteImage(for id: UUID) async {
        let fileURL = imagesDirectoryURL.appendingPathComponent("\(id.uuidString).png")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try? FileManager.default.removeItem(at: fileURL)
        }
    }
}

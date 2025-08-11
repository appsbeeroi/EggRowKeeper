import Foundation
import RealmSwift

@globalActor
actor MainGlobalActor {
    static let shared = MainGlobalActor()
}

final class DatabaseService: ObservableObject {
    
    var realmManager: Realm?
    
    init() {
        Task {
            await initiateRealmManager()
        }
    }
    
    @MainGlobalActor
    private func initiateRealmManager() async {
        do {
            realmManager = try await Realm(actor: MainGlobalActor.shared)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension DatabaseService {
    @MainGlobalActor
    func save<T: Object>(_ object: T) async {
        guard let realmManager else { return }
        
        do {
            try realmManager.write {
                realmManager.add(object, update: .all)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainGlobalActor
    func fetchAll<T: Object>() async -> [T] {
        guard let realmManager else { return [] }
        let objects = realmManager.objects(T.self)
        
        return Array(objects)
    }
    
    @MainGlobalActor
    func remove<T: Object>(_ object: T, with key: UUID) async {
        guard let realmManager,
              let object = realmManager.object(ofType: T.self, forPrimaryKey: key) else { return }
        
        do {
            try realmManager.write {
                realmManager.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainGlobalActor
    func removeAll() async {
        guard let realmManager else { return }
        
        do {
            try realmManager.write {
                realmManager.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

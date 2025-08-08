import Foundation

enum EggOfTheDayState: String {
    case philosopher
    case cautious
    case proud
    
    var icon: ImageResource {
        switch self {
            case .philosopher:
                    .Images.Eggs.eggPhilosopher
            case .cautious:
                    .Images.Eggs.cautiousEgg
            case .proud:
                    .Images.Eggs.proudEgg
        }
    }
}

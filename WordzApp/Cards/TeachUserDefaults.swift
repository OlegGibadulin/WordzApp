import Foundation

class TeachUserDefaults {
    private enum TeachEnum: String {
        case teach
    }
    
    static var showSwipeAlerts: Int {
        get {
            return UserDefaults.standard.integer(forKey: TeachEnum.teach.rawValue)
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = TeachEnum.teach.rawValue
            defaults.set(newValue, forKey: key)
        }
    }
    
    static func addTeachSwipes() {
        TeachUserDefaults.showSwipeAlerts += 1
    }
}

import Foundation

class Purchases {
    private enum PurchasesEnum: String {
        case fullVersion
    }
    
    static var fullVersion: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: PurchasesEnum.fullVersion.rawValue)
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = PurchasesEnum.fullVersion.rawValue
            if newValue == true {
                defaults.set(newValue, forKey: key)
            }
        }
    }
}

import Foundation

class StatisticCollector {
    private enum StatisticEnum: String {
        case rightSwipes
        case leftSwipes
        case totalSwipes
    }
    
    static var swipesToRight: Int! {
        get {
            if (UserDefaults.standard.integer(forKey: StatisticEnum.rightSwipes.rawValue) == 0) {
                return 0
            }
            return UserDefaults.standard.integer(forKey: StatisticEnum.rightSwipes.rawValue)
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = StatisticEnum.rightSwipes.rawValue
            if newValue > 0 {
                defaults.set(newValue, forKey: key)
            }
        }
    }
    
    static var swipesToLeft: Int! {
        get {
            if (UserDefaults.standard.integer(forKey: StatisticEnum.leftSwipes.rawValue) == 0) {
                return 0
            }
            return UserDefaults.standard.integer(forKey: StatisticEnum.leftSwipes.rawValue)
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = StatisticEnum.leftSwipes.rawValue
            if newValue > 0 {
                defaults.set(newValue, forKey: key)
            }
        }
    }
    
    static var totalSwipes: Int! {
        get {
            return StatisticCollector.swipesToLeft + StatisticCollector.swipesToRight
        }
    }
    
    static func addToStatistic(unfamilarWords: Int, familarWords: Int) {
        StatisticCollector.swipesToLeft += unfamilarWords
        StatisticCollector.swipesToRight += familarWords
    }
}

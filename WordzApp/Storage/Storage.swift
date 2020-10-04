import UIKit

struct Storage {
    
    static var shared = Storage()
    
    // MARK: - Levels
    
    let levels = [
        LevelStorage(title: "Начинающий", sentences: Beginner),
        LevelStorage(title: "Средний", sentences: Intermediate),
        LevelStorage(title: "Продвинутый", sentences: Advanced),
    ]
    
    // TODO: Make it via UserDefaults if it will be needed for future settings
    let everydaySentencesCount = 10
    
    // MARK: - Categories
    
    let todayCardsTitle = "Сегодня"
    let favouritesTitle = "Избранное"
    
    lazy var categories: [CategoryStorage] = [
        CategoryStorage(title: todayCardsTitle, firstColor: #colorLiteral(red: 0.3058823529, green: 0.631372549, blue: 0.9725490196, alpha: 1), secondColor: #colorLiteral(red: 0.6908428073, green: 0.9608913064, blue: 0.7938471437, alpha: 1)),
        CategoryStorage(title: favouritesTitle, firstColor: #colorLiteral(red: 0.8901960784, green: 0.6274509804, blue: 0.2470588235, alpha: 1), secondColor: #colorLiteral(red: 0.9026226401, green: 0.8602350354, blue: 0.4391778111, alpha: 1)),
        CategoryStorage(title: "Архитектура", firstColor: #colorLiteral(red: 0.9215686275, green: 0.3725490196, blue: 0.2431372549, alpha: 1), secondColor: #colorLiteral(red: 0.8901960784, green: 0.6078431373, blue: 0.2392156863, alpha: 1), sentences: Architecture),
        CategoryStorage(title: "Эмоции", firstColor: #colorLiteral(red: 0.7803921569, green: 0.2156862745, blue: 0.9647058824, alpha: 1), secondColor: #colorLiteral(red: 0.5490196078, green: 0.2274509804, blue: 0.8980392157, alpha: 1), sentences: Emotion),
        CategoryStorage(title: "Дом", firstColor: #colorLiteral(red: 0.9333333333, green: 0.5254901961, blue: 0.4078431373, alpha: 1), secondColor: #colorLiteral(red: 0.9490196078, green: 0.7176470588, blue: 0.5176470588, alpha: 1), sentences: House),
        CategoryStorage(title: "Части тела", firstColor: #colorLiteral(red: 0.8159528375, green: 0.8317103982, blue: 0.3640093207, alpha: 1), secondColor: #colorLiteral(red: 0.4391376376, green: 0.9119202495, blue: 0.3528954387, alpha: 1), sentences: BodyParts),
        CategoryStorage(title: "Инструменты", firstColor: #colorLiteral(red: 0.2980392157, green: 0.8478753273, blue: 0.6823529412, alpha: 1), secondColor: #colorLiteral(red: 0.3647058824, green: 0.7882352941, blue: 0.6784313725, alpha: 1), sentences: Tools),
        CategoryStorage(title: "Спорт", firstColor: #colorLiteral(red: 0.9019607843, green: 0.3882352941, blue: 0.6392156863, alpha: 1), secondColor: #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.3725490196, alpha: 1), sentences: Sport),
        CategoryStorage(title: "Напитки", firstColor: #colorLiteral(red: 0.7803921569, green: 0.2156862745, blue: 0.9647058824, alpha: 1), secondColor: #colorLiteral(red: 0.7803921569, green: 0.8666666667, blue: 0.9647058824, alpha: 1), sentences: Drinks),
        CategoryStorage(title: "Одежда", firstColor: #colorLiteral(red: 0.843957305, green: 0.830924809, blue: 0.4867311716, alpha: 1), secondColor: #colorLiteral(red: 0.8665418029, green: 0.8755096793, blue: 0.3502323627, alpha: 1), sentences: Clothes),
        CategoryStorage(title: "Местность", firstColor: #colorLiteral(red: 0.7803921569, green: 0.2156862745, blue: 0.9647058824, alpha: 1), secondColor: #colorLiteral(red: 0.5490196078, green: 0.2274509804, blue: 0.8980392157, alpha: 1), sentences: Land),
        CategoryStorage(title: "Животные", firstColor: #colorLiteral(red: 0.9231296182, green: 0.8337054253, blue: 0.4173160195, alpha: 1), secondColor: #colorLiteral(red: 0.9490196078, green: 0.6705882353, blue: 0.3803921569, alpha: 1), sentences: Animals),
        CategoryStorage(title: "Цвета", firstColor: #colorLiteral(red: 0.9215686275, green: 0.3725490196, blue: 0.2431372549, alpha: 1), secondColor: #colorLiteral(red: 0.8901960784, green: 0.6078431373, blue: 0.2392156863, alpha: 1), sentences: Colors),
        CategoryStorage(title: "Работа", firstColor: #colorLiteral(red: 0.2980392157, green: 0.8478753273, blue: 0.6823529412, alpha: 1), secondColor: #colorLiteral(red: 0.3647058824, green: 0.7882352941, blue: 0.6784313725, alpha: 1), sentences: Jobs),
        CategoryStorage(title: "Маркетинг", firstColor: #colorLiteral(red: 0.9215686275, green: 0.3529411765, blue: 0.2078431373, alpha: 1), secondColor: #colorLiteral(red: 0.9411764706, green: 0.5843137255, blue: 0.4392156863, alpha: 1), sentences: Marketing)
    ]
    
    let levelsTitle = [
        "Начинающий": "TodayBegginer",
        "Средний": "TodayIntermediate",
        "Продвинутый": "TodayAdvanced",
    ]
    
    lazy var categoriesForLevels: [CategoryStorage] = self.levels.map { (level) -> CategoryStorage in
        return CategoryStorage(title: levelsTitle[level.title]!, isHidden: true)
    }
    
}

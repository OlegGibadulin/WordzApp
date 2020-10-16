import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    var sentence: Sentence! {
        didSet {
            sentenceLabel.text = sentence.text
            
            var translations = ""
            sentence.translation?.forEach({ (translation) in
                translations += translation + "\n"
            })
            translations.remove(at: translations.index(before: translations.endIndex))
            translationLabel.text = translations
        }
    }
    
    fileprivate let sentenceLabel: UILabel = {
        let sl = UILabel()
        sl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        sl.numberOfLines = 0
        return sl
    }()
    
    fileprivate let translationLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        tl.numberOfLines = 0
        return tl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [sentenceLabel, translationLabel])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 4
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 24, bottom: 16, right: 16))
        
        guard let image = UIImage(named: "learnedIndicator") else { return }
        
        setupImageView(image: image)
        self.indicatorImageView?.alpha = 0
    }
    
    var indicatorImageView: UIImageView?
    
    func setupImageView(image: UIImage) {
        indicatorImageView = UIImageView(image: image)
        guard let indicatorImageView = indicatorImageView else { return }
        indicatorImageView.contentMode = .scaleAspectFit
        indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorImageView)
        indicatorImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -23).isActive = true
        indicatorImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicatorImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        indicatorImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    func showImage(isNeedToShow: Bool) {
        if (isNeedToShow == true) {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
                self.indicatorImageView?.alpha = 1
            } completion: { (_) in
                
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
                self.indicatorImageView?.alpha = 0
            } completion: { (_) in
                
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

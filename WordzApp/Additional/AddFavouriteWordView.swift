//
//  AddFavouriteWordView.swift
//  WordzApp
//
//  Created by Антон Тимонин on 16.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
import CoreData

protocol PopUpDelegate {
    func handleDismissal()
    func showAlert(alert: UIAlertController)
}

final class AddFavouriteWordView: UIView {
    
    var delegate: PopUpDelegate?
    
    var enteredWord: Word! = Word(word: "", translate: [""])
    
    let addButton: UIButton = {
        let addButton = UIButton()
        addButton.isEnabled = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitleColor(#colorLiteral(red: 0.01960784314, green: 0, blue: 0.5370023545, alpha: 1), for: .highlighted)
        return addButton
    }()
    
    let cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = .white
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(#colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1), for: .normal)
        cancelButton.setTitleColor(#colorLiteral(red: 0.4800369955, green: 0.4956656678, blue: 1, alpha: 1), for: .highlighted)
        return cancelButton
    }()
    
    let wordTextField: UITextField = {
       let wordTextField = UITextField()
        wordTextField.placeholder = "Слово"
        wordTextField.borderStyle = .roundedRect
        wordTextField.translatesAutoresizingMaskIntoConstraints = false
        return wordTextField
    }()
    
    let translateTextField: UITextField = {
       let translateTextField = UITextField()
        translateTextField.placeholder = "Перевод"
        translateTextField.borderStyle = .roundedRect
        translateTextField.translatesAutoresizingMaskIntoConstraints = false
        return translateTextField
    }()
    
    private var titleStackView: UIStackView!
    private var textFieldsStackView: UIStackView!
    private var buttonsStackView: UIStackView!
    private var overallStackView: UIStackView!
    private var emptyStackView1: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [UIView()])
        return sv
    }()
    
    private var emptyStackView2: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [UIView()])
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupStackViews()
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    private func setupLayout() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 23
        self.clipsToBounds = true
    }
    
    private func setupStackViews() {
        setupTitleStackView()
        setupTextFieldStackView()
        setupButtonsStackView()
        setupOverallStackView()
        setupAnchors()
        
        emptyStackView1.translatesAutoresizingMaskIntoConstraints = false
        emptyStackView2.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTitleStackView() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        titleLabel.text = "Добавить новое слово"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .white
        
        titleStackView = UIStackView(arrangedSubviews: [titleLabel])
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.distribution = .equalSpacing
        
//        self.addSubview(titleStackView)
    }
    
    private func setupTextFieldStackView() {
        let verticalStackView = UIStackView(arrangedSubviews: [wordTextField, translateTextField])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 15
        
        wordTextField.addTarget(self, action: #selector(textFieldTarget(sender:)), for: .allEditingEvents)
        translateTextField.addTarget(self, action: #selector(textFieldTarget(sender:)), for: .allEditingEvents)
        
        textFieldsStackView = UIStackView(arrangedSubviews: [verticalStackView])
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldsStackView.axis = .horizontal
        textFieldsStackView.distribution = .equalSpacing
        
//        self.addSubview(textFieldsStackView)
    }
    
    private func setupButtonsStackView() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(sedner:)), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped(sedner:)), for: .touchUpInside)
        buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, addButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 0
        buttonsStackView.distribution = .fill
    }
    
    private func setupOverallStackView() {
        overallStackView = UIStackView(arrangedSubviews: [titleStackView, emptyStackView1, textFieldsStackView, emptyStackView2, buttonsStackView])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        
        self.addSubview(overallStackView)
        overallStackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func setupAnchors() {
        titleStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        wordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        translateTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textFieldsStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        textFieldsStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        textFieldsStackView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        
        buttonsStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalTo: addButton.widthAnchor, multiplier: 1).isActive = true
        emptyStackView1.heightAnchor.constraint(equalTo: emptyStackView2.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    // MARK:- Selectors
    
    @objc
    private func cancelButtonTapped(sedner: UIButton) {
        delegate?.handleDismissal()
    }
    
    @objc
    private func addButtonTapped(sedner: UIButton) {
        //CoreDataManager.shared.favouriteSentence(sentence: sentence)
        if (wordTextField.text!.count > 1 && translateTextField.text!.count > 1) {
            let word = wordTextField.text!
            let translation = [translateTextField.text!]
            
            if CoreDataManager.shared.addFavouriteSentence(text: word, translation: translation) == false {
                showAlert(title: "Не удалось добавить слово", message: "Непрафильный формат ввода")
            }
        }
        delegate?.handleDismissal()
    }
    
    @objc
    private func textFieldTarget(sender: UITextField) {
        updateStateButtons()
    }
    
    private func updateStateButtons() {
        if (wordTextField.text!.count > 1 && translateTextField.text!.count > 1) {
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(action)
        delegate?.showAlert(alert: alert)
    }
}

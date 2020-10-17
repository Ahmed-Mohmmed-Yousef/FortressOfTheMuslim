//
//  SettingsVC.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/17/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, SettingsView {
    
    var presenter: SettingsVCPresenter?
    
    
    private lazy var languageButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.backgroundColor
        configLanguageButton()

    }
    
    private func configLanguageButton() {
        view.addSubview(languageButton)
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        languageButton.setTitle("Change Language".localized, for: .normal)
        languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        languageButton.setTitleColor(Theme.textColor, for: .normal)
        languageButton.titleLabel?.font = .systemFont(ofSize: 18)
        languageButton.layer.borderWidth  = 2
        languageButton.layer.borderColor  = UIColor.gray.cgColor
        languageButton.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            languageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            languageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            languageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            languageButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func languageButtonTapped() {
        presenter?.changeLanguage()
    }

}

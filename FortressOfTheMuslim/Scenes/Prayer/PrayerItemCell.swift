//
//  PrayerItemCellCollectionViewCell.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/13/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit
import AVFoundation

protocol PrayerItemCellDelegate: class {
    func incremntCount(of cell: PrayerItemCellView, at index: Int)
}

class PrayerItemCell: UICollectionViewCell {
    static let id = "PrayerItemCell"
    
    var cellIndex: Int!
    
    private var containerView   = UIView()
    private var textLabel       = BodyLabel(textAlignment: .natural)
    private var counterLabel    = BodyLabel(textAlignment: .center)
    private var continueButton  = UIButton(type: .system)
    
    private var numberOfRepetions = 0 {
        didSet {
            updateCounterLabel()
        }
    }
    var count: Int = 0 {
        didSet {
            updateCounterLabel()
        }
    }
    
    var delegate: PrayerItemCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = Theme.backgroundColor
        contentView.tintColor = Theme.tintColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handelContinueButton() {
        delegate?.incremntCount(of: self, at: cellIndex)
    }
    
    private func updateCounterLabel() {
        let atributedText = NSMutableAttributedString(string: "\(count) \("of".localized)",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        atributedText.append(NSAttributedString(string: " \(numberOfRepetions)",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
                         NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        counterLabel.attributedText = atributedText
    }
    
    
    
    private func configure() {
        contentView.addSubview(containerView)
        contentView.backgroundColor = Theme.backgroundColor

        containerView.addSubViews(views: textLabel,
                                  counterLabel,
                                  continueButton)
        translatesAutoresizingMaskIntoConstraints = false

        textLabel.numberOfLines = 0
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelContinueButton)))
        containerView.backgroundColor = Theme.cellBackgroundCololr
        containerView.isUserInteractionEnabled = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        continueButton.setTitle("Continue".localized, for: .normal)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        continueButton.addTarget(self, action: #selector(handelContinueButton), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            textLabel.bottomAnchor.constraint(equalTo: counterLabel.topAnchor, constant: -12),
            
            continueButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            continueButton.widthAnchor.constraint(equalToConstant: 100),
            continueButton.heightAnchor.constraint(equalToConstant: 100),
            
            counterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            counterLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        
        containerView.layer.borderWidth   = 2.0
        containerView.layer.borderColor   = UIColor.gray.cgColor
        containerView.layer.cornerRadius  = 10
    }
}

extension PrayerItemCell: PrayerItemCellView {
    
    func displayText(text: String?) {
        textLabel.text = text
    }
    
    func numberOfRepetion(number: Int) {
        count = 0
        numberOfRepetions = number
    }
    
    func incrementCount(with value: Int) {
        count = value
    }
    
    
}

//
//  FavoriteCell.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate: class {
    func removeFavorite(prayerTitel: String, at index: Int)
}

class FavoriteCell: UITableViewCell {

    static let id = "FavoriteCell"
    
    private lazy var titleLabel     = TitleLabel()
    private lazy var deleteButton     = UIButton()
    private lazy var containerView  = UIView()
    
    var cellIndex: Int!
    weak var delegate: FavoriteCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configueration()
    }
    
    @objc private func deleteTapped() {
        delegate?.removeFavorite(prayerTitel: titleLabel.text!, at: cellIndex)
    }
    
    private func configueration() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        contentView.backgroundColor = Theme.backgroundColor
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(deleteButton)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor       = Theme.cellBackgroundCololr
        containerView.layer.borderWidth     = 2
        containerView.layer.borderColor     = UIColor.gray.cgColor
        containerView.layer.cornerRadius    = 10
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        deleteButton.setTitle("Delete".localized, for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.tintColor          = .red
        deleteButton.layer.borderWidth  = 2
        deleteButton.layer.borderColor  = UIColor.red.cgColor
        deleteButton.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            deleteButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            deleteButton.widthAnchor.constraint(equalToConstant: 60),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteCell: FavoriteCellView {

    func displayTitle(text: String) {
        titleLabel.text = text
    }
    
    func isFavorite(status: Bool) {
    }

}

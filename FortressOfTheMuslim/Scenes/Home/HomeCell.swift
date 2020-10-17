//
//  HomeCell.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/14/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

protocol HomeCellDelegate: class {
    func favoriteToggled(at index: Int)
}
class HomeCell: UITableViewCell {
    static let id = "HomeCell"
    
    private lazy var titleLabel     = TitleLabel()
    private lazy var starButton     = UIButton()
    private lazy var containerView  = UIView()
    
    var cellIndex: Int!
    weak var delegate: HomeCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configueration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func starTapped() {
        delegate?.favoriteToggled(at: cellIndex)
    }
    
    private func configueration() {
        selectionStyle = .none
        contentView.backgroundColor = Theme.backgroundColor
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(starButton)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor       = Theme.cellBackgroundCololr
        containerView.layer.borderWidth     = 2
        containerView.layer.borderColor     = UIColor.gray.cgColor
        containerView.layer.cornerRadius    = 10
        
        starButton.translatesAutoresizingMaskIntoConstraints = false
        starButton.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
        starButton.tintColor    = .orange
        starButton.contentMode  = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            starButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            starButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            starButton.widthAnchor.constraint(equalToConstant: 20),
            starButton.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: starButton.leadingAnchor, constant: -8)
        ])
    }
    
}

extension HomeCell: HomeCellView {

    func displayTitle(text: String) {
        titleLabel.text = text
    }
    
    func isFavorite(status: Bool) {
        let imageName = status ? "favorite" : "favorite-un"
        starButton.setImage(UIImage(named: imageName), for: .normal)
    }

}

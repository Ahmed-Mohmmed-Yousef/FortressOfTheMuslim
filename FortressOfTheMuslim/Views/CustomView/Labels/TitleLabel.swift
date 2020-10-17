//
//  TitleLabel.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/13/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.font = Fonts.languageFont(with: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = Fonts.languageFont(with: fontSize)
    }
    
    fileprivate func configure(){
        textColor                   = Theme.textColor
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        numberOfLines               = 2
        translatesAutoresizingMaskIntoConstraints = false
    }

}

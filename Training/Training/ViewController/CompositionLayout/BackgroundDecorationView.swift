//
//  BackgroundDecorationView.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit

/// A basic decoration view used for section backgrounds.
final class BackgroundDecorationView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        backgroundColor = UIColor(white: 0.85, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


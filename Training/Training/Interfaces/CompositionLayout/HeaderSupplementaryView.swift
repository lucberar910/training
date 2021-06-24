//
//  HeaderSupplementaryView.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit

class HeaderSupplementaryView: UICollectionReusableView {

    struct ViewModel {
        let title: String
    }
    
    @IBOutlet private weak var label: UILabel!
    
    var viewModel: ViewModel? {
        didSet {
            label.text = viewModel?.title
        }
    }
    
}

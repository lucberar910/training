//
//  CVLayout.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import Foundation
import UIKit

class CVLayout : UICollectionViewFlowLayout {
    
    // numero di colonne
    var nColonne : Int!
    // altezza degli item
    var cellHeight : Int!
    // spaziatura tra un item e l'altro
    var interItemSpacing: CGFloat!
    // spaziatura tra una riga e l'altra
    var lineSpacing : CGFloat!
    
    init(nCols : Int, cellHeight : Int!, interItemSpace : CGFloat, lineSpace : CGFloat) {
        super.init()
        nColonne = nCols
        self.cellHeight = cellHeight
        interItemSpacing = interItemSpace
        lineSpacing = lineSpace
        
        // imposto le proprietà del layout (superclasse)
        minimumLineSpacing = lineSpacing
        minimumInteritemSpacing = interItemSpacing
    }
    
    override var itemSize: CGSize {
        get {
            // WIDTH = (CV_WIDTH - INTERITEMSPACE) / NCOL
            let cellWidth = (collectionView!.frame.size.width - ((interItemSpacing * CGFloat(nColonne)) - 1)) / CGFloat(nColonne)
            return CGSize(width: cellWidth, height: CGFloat(cellHeight))
        }
        set {}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


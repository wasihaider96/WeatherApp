//
//  CustomCollectionView.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit

class CustomCollectionView: UICollectionViewCell {
    
    static let indentifier = "CustomCollectionView"
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bottomTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    func prepare(_ firstCollectionView: firstCollectionView) {
        self.image.image = UIImage(named: firstCollectionView.image)
        topTitle.text = firstCollectionView.topTitle
        bottomTitle.text = firstCollectionView.bottomTitle
    }
}

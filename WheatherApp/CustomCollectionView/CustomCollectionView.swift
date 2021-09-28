//
//  CustomCollectionView.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit

class CustomCollectionView: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let indentifier = "CustomCollectionView"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bottomTitle: UILabel!
    
    // MARK: - Variables
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    // MARK: - Custom Functions
    
    func prepare(_ WeatherRegardingTime: WeatherRegardingTime) {
        self.image.image = UIImage(named: WeatherRegardingTime.image)
        topTitle.text = WeatherRegardingTime.topTitle
        bottomTitle.text = WeatherRegardingTime.bottomTitle
        
    }
}

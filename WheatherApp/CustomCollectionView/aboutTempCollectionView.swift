//
//  aboutTempCollectionView.swift
//  WheatherApp
//
//  Created by Apple on 15/09/2021.
//

import UIKit

class aboutTempCollectionView: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let indentifier = "aboutTempCollectionView"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var value: UILabel!
   
    // MARK: - Variables
   
    var weather = [WeatherDetail]()
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    // MARK: - Custom Functions
    
    func weatherDetail(_ EnviromentCollectionView: Enviroment ){
        sunrise.text = EnviromentCollectionView.sunrise
        value.text = String(format: "%.1f", EnviromentCollectionView.value)
    }
}

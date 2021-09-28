//
//  aboutTempCollectionView.swift
//  WheatherApp
//
//  Created by Apple on 15/09/2021.
//

import UIKit

class aboutTempCollectionView: UICollectionViewCell {
    
    static let indentifier = "aboutTempCollectionView"
    
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var value: UILabel!
   
    var weather = [weatherModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func weatherDetail(_ EnviromentCollectionView: EnviromentCollectionView ){
        sunrise.text = EnviromentCollectionView.sunrise
        value.text = String(format: "%.1f", EnviromentCollectionView.value)
    }
}

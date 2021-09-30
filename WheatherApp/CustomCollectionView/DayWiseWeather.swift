//
//  DayWiseWeather.swift
//  WheatherApp
//
//  Created by Apple on 28/09/2021.
//

import UIKit

class DayWiseWeather: UITableViewCell {

    // MARK: - Identifier
    static let indentifier = "DayWiseWeather"
    
    // MARK: - IBoulets
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //weatherImg.kf.setImage(with: )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(_ tableInfo: DayWiseData) {
        
        
        dayLabel.text = tableInfo.dayTitle
        weatherImg.setImage(tableInfo.image)
        highTempLbl.text = tableInfo.highTempTitle
        lowTempLbl.text = tableInfo.lowTempTitle
    }
}

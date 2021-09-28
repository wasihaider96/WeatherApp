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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(_ tableInfo: DayWiseData) {
        
    }
}

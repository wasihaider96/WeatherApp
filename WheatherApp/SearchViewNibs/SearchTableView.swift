//
//  SearchTableView.swift
//  WheatherApp
//
//  Created by Apple on 16/09/2021.
//

import UIKit

class SearchTableView: UITableViewCell {

    static let indentifier = "SearchTableView"
    //IBOulets
    
    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func prepare(_ SearchBar: SearchBar) {
        
        cityName.text = SearchBar.cityName
      
    }
}

//
//  SearchTableView.swift
//  WheatherApp
//
//  Created by Apple on 16/09/2021.
//

import UIKit

class SearchTableView: UITableViewCell {

    // MARK: - Identifier
    
    static let indentifier = "SearchTableView"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityName: UILabel!
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Custom Functions
    
    func prepare(_ SearchBar: SearchBar) {
        
        cityName.text = SearchBar.cityName
      
    }
}

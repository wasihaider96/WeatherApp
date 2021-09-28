//
//  CustomTableCellThree.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit

class CustomTableCellThree: UITableViewCell {
    
    // MARK: - Identifier
    
    static let indentifier = "CustomTableCellThree"

    // MARK: - IBOutlets
    @IBOutlet weak var WheatherView: UIView!
    @IBOutlet weak var TodayWheatherLabel: UILabel!
    
    // MARK: - Variables
    
    
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
    func tableView() {
    
    }
    
}



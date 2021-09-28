//
//  WheatherForcastingCell.swift
//  WheatherApp
//
//  Created by Apple on 14/09/2021.
//

import UIKit

class WheatherForcastingCell: UITableViewCell {
    
    // MARK: - Identifier
    static let indentifier = "WheatherForcastingCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var openMap: UIButton!
    
    // MARK: - Variables
    var clickHandler: ((Int) -> Void)?
    
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
    
    // MARK: - IBActions
    @IBAction func openMapBtn(_ sender: UIButton) {
        guard let completion = self.clickHandler else {return}
        completion(0)
    }
    
    // MARK: - Custom Functions
    
    func watchForClickHandler(completion: @escaping (Int) -> Void) {
        self.clickHandler = completion
    }
}

//
//  CustomTableCellTwo.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit

class CustomTableCellTwo: UITableViewCell {
    
    // MARK: - Identifier
    static let indentifier = "CustomTableCellTwo"
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var tableViewCell = [DayWiseData]()
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tableIntializer()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: DayWiseWeather.indentifier, bundle: nil), forCellReuseIdentifier: DayWiseWeather.indentifier)
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func tableIntializer() {
        
        
    }
    
}

extension CustomTableCellTwo: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayWiseWeather.indentifier, for: indexPath) as? DayWiseWeather else {
            return UITableViewCell()
        }
        cell.prepare(tableViewCell[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

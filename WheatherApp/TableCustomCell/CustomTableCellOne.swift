//
//  CustomTableCellOne.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit

class CustomTableCellOne: UITableViewCell {
    
    // MARK: - Identifier
    
    static let indentifier = "CustomTableCellOne"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    
    var tableCell = [firstCollectionView]()
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wheatherData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CustomCollectionView.indentifier, bundle: nil),forCellWithReuseIdentifier: CustomCollectionView.indentifier)
        collectionView.updateFLow(itemSpacing: 5, lineSpacing: 5, true)
       
        collectionView.clearBackground()

        // Initialization code
    }
    
    // MARK: - Custom Functions
    
    func wheatherData() {
        
        tableCell.append(firstCollectionView(image: "cloud.png", topTitle: "Now", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image:"sunny.png", topTitle: "1PM", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "2PM", bottomTitle: "32"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "3PM", bottomTitle: "32"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "4PM", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "5PM", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "6PM", bottomTitle: "29"))
        tableCell.append(firstCollectionView(image: "sunset.png", topTitle: "6:11PM", bottomTitle: "Sunset"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "7PM", bottomTitle: "29"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "8PM", bottomTitle: "28"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "9PM", bottomTitle: "27"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "10PM", bottomTitle: "27"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "11PM", bottomTitle: "27"))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension CustomTableCellOne: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableCell.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionView.indentifier , for: indexPath ) as? CustomCollectionView else {
            return UICollectionViewCell()
        }
        
        cell.prepare(tableCell[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 6 , height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

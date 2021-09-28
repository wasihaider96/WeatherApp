//
//  TableCellOne.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit

class TableCellOne: UITableViewCell {
    
    // MARK: - Identifier
    static let indentifier = "TableCellOne"
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var tableCell = [WeatherRegardingTime]()
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CustomCollectionView.indentifier, bundle: nil),forCellWithReuseIdentifier: CustomCollectionView.indentifier)
        collectionView.updateFLow(itemSpacing: 5, lineSpacing: 5, true)
       
        collectionView.clearBackground()

        // Initialization code
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension TableCellOne: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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

//
//  SunriseSunsetTableCell.swift
//  WheatherApp
//
//  Created by Apple on 14/09/2021.
//

import UIKit

class SunriseSunsetTableCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let indentifier = "SunriseSunsetTableCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    
    var enviromentCEll = [Enviroment]()
    var weather = [WeatherDetail]()
    var extraDuplicateArr = [WeatherDetail]()
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: aboutTempCollectionView.indentifier, bundle: nil),forCellWithReuseIdentifier: aboutTempCollectionView.indentifier)
        collectionView.updateFLowTwo(itemSpacing: 5, lineSpacing: 5, false)
        collectionView.clearBackground()
        
        // Initialization code
    }
    
    // MARK: - Custom Functions
    
    func prepareCellFor(_ data: [Enviroment])  {
        enviromentCEll = data
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
extension SunriseSunsetTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
        return enviromentCEll.count
        //return weather.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: aboutTempCollectionView.indentifier , for: indexPath ) as? aboutTempCollectionView else {
            return UICollectionViewCell()
        }
        
        cell.weatherDetail(enviromentCEll[indexPath.row])
        //cell.prepare(weather[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2.5, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

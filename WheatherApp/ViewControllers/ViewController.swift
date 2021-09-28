//
//  ViewController.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, LocationDataPass {
    
    //var viewModel = wheatherViewModel()
    
    // MARK: - Identifier
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topDegreeView: UIView!
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var highestTemp: UILabel!
    @IBOutlet weak var weatherState: UILabel!
    @IBOutlet weak var lowestTemp: UILabel!
    
    // MARK: - Variables
    
    var locationSearch: LocationData?
    var weatherModelData = [weatherModel]()
    var tableCell = [firstCollectionView]()
    var isTopHide = false
    var isTableViewScroll = false
    var imageview : UIImageView? = nil
    private var isScrollUp = false
    
    var defaultWeatherData = [weatherModel]()
    var locatonModelData = [LocationData]()
    var enviromentCEll = [EnviromentCollectionView]()
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //API - Calling:
        
        DefaultLocationDetail()
        DefaultWeatherDetail()
    
        wheatherData()
        // Initialization code
        
        // Collection View Inshilization
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CustomCollectionView.indentifier, bundle: nil),forCellWithReuseIdentifier: CustomCollectionView.indentifier)
        collectionView.updateFLow(itemSpacing: 5, lineSpacing: 5, true)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clearBackground()
        
        // Table View Inshilization
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CustomTableCellTwo.indentifier, bundle: nil), forCellReuseIdentifier: CustomTableCellTwo.indentifier)
        tableView.register(UINib(nibName: CustomTableCellThree.indentifier, bundle: nil), forCellReuseIdentifier: CustomTableCellThree.indentifier)
        tableView.register(UINib(nibName: SunriseSunsetTableCell.indentifier, bundle: nil), forCellReuseIdentifier: SunriseSunsetTableCell.indentifier)
        tableView.register(UINib(nibName: WheatherForcastingCell.indentifier, bundle: nil), forCellReuseIdentifier: WheatherForcastingCell.indentifier)
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
    }
    
    // Functions
        
    func locationDataPass(locationData: LocationData) {
        
        locationNameLbl.text =  locationData.title!
        
        print(locationData.woeid ?? "")
        self.locationSearch = locationData
        GetWeatherDetail()
    }
    
    //\(searchBar.text ?? "")
    
    func DefaultLocationDetail() {
        let requestURL = "https://www.metaweather.com/api/location/search/?query=karachi"
        NetworkManager.shared.GetLocationDetail(requestURL) { success, message, location in
            if success {
                if let location = location {
                    self.locatonModelData = location
                    self.defaultLocationAssign(LocatonModelData: self.locatonModelData)
                    self.tableView.reloadData()
                }
            } else {
                print(message)
            }
        }
    }
    
    func DefaultWeatherDetail() {
        
        let requestURL = "https://www.metaweather.com/api/location/2211096"
        NetworkManager.shared.GetWeatherDetail(requestURL) { success, message, weather in
            if success {
                if let weather = weather {
                    self.defaultWeatherData = weather
                    self.weatherDetail(extraDuplicateArr: self.defaultWeatherData)
                    
                    self.defualtWeatherValue(defaultWeatherData: self.defaultWeatherData)
                    self.tableView.reloadData()
                }
            } else {
                print(message)
            }
        }
    }
    
    func GetWeatherDetail() {
        guard let id = locationSearch?.woeid else {
            return
        }
        let requestURL = "https://www.metaweather.com/api/location/\(id)"
        NetworkManager.shared.GetWeatherDetail(requestURL) { success, message, weather in
            if success {
                if let weather = weather {
                    self.defaultWeatherData = weather
                    self.weatherDetail(extraDuplicateArr: self.defaultWeatherData)
                    self.assingningValue(weatherModelData: self.defaultWeatherData)
                    self.tableView.reloadData()
                }
            } else {
                print(message)
            }
        }
    }

    func weatherDetail(extraDuplicateArr: [weatherModel]) {
    
        enviromentCEll.removeAll()
        
        if extraDuplicateArr.count > 0 {
            
        enviromentCEll.append(EnviromentCollectionView( sunrise: "SUNRISE", value: Double(extraDuplicateArr[0].min_temp!)))
        enviromentCEll.append(EnviromentCollectionView( sunrise: "SUNSET", value: extraDuplicateArr[0].min_temp!))
        enviromentCEll.append(EnviromentCollectionView( sunrise: "WIND", value: extraDuplicateArr[0].wind_speed!))
        enviromentCEll.append(EnviromentCollectionView( sunrise: "HUMIDITY", value: extraDuplicateArr[0].humidity!))
        enviromentCEll.append(EnviromentCollectionView( sunrise: "VISIBILITY", value: extraDuplicateArr[0].visibility!))
        enviromentCEll.append(EnviromentCollectionView( sunrise: "PRESSURE", value: extraDuplicateArr[0].air_pressure!))
        enviromentCEll.append(EnviromentCollectionView( sunrise: "DIRECTION", value: extraDuplicateArr[0].wind_direction!))
        enviromentCEll.append(EnviromentCollectionView( sunrise: "PREDICTABILITY", value: extraDuplicateArr[0].predictability!))
       
        }
    }
    
    func defaultLocationAssign(LocatonModelData: [LocationData]) {
            
        locationNameLbl.text = LocatonModelData[0].title
    }
    
    func defualtWeatherValue(defaultWeatherData: [weatherModel]){
        
        lowestTemp.text = String(format: "%.2f", defaultWeatherData[0].min_temp!)
        highestTemp.text = String(format: "%.2f", defaultWeatherData[0].max_temp!)
        degreeLabel.text = String(format: "%.0f", defaultWeatherData[0].the_temp!)
        weatherState.text = defaultWeatherData[0].weather_state_name
    }
    
    func assingningValue(weatherModelData: [weatherModel]) {

        lowestTemp.text = String(format: "%.2f", weatherModelData[0].min_temp!)
        highestTemp.text = String(format: "%.2f", weatherModelData[0].max_temp!)
        degreeLabel.text = String(format: "%.0f", weatherModelData[0].the_temp!)
        weatherState.text = weatherModelData[0].weather_state_name
    }

    //Data for Weather time Collection View
    
    func wheatherData() {
        
        tableCell.append(firstCollectionView(image: "cloud.png", topTitle: "Now", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "1PM", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "2PM", bottomTitle: "32"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "3PM", bottomTitle: "32"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "4PM", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "5PM", bottomTitle: "31"))
        tableCell.append(firstCollectionView(image: "sunny.png", topTitle: "6PM", bottomTitle: "29"))
        tableCell.append(firstCollectionView(image: "sunset.png", topTitle: "6PM", bottomTitle: "Sunset"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "7PM", bottomTitle: "29"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "8PM", bottomTitle: "28"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "9PM", bottomTitle: "27"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "10PM", bottomTitle: "27"))
        tableCell.append(firstCollectionView(image: "night-mode.png", topTitle: "11PM", bottomTitle: "27"))
    }
    
    func adjustTopView(_ height: CGFloat, _ topHide: Bool ) {
        view.layoutIfNeeded()
        heightConstrain.constant = height
        isTopHide = topHide
    }
    
    @IBAction func searchBar(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "SearchBAr") as! SearchBAr
        vc.delegate = self
        self.navigationController?.pushViewController( vc , animated: true)
        
    }
    
}

//Table View Extension

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCellTwo.indentifier, for: indexPath) as? CustomTableCellTwo else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            return cell
        } else if indexPath.row == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCellThree.indentifier, for: indexPath) as? CustomTableCellThree else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            
            return cell
        } else if indexPath.row == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SunriseSunsetTableCell.indentifier, for: indexPath) as? SunriseSunsetTableCell else {
                return UITableViewCell()
            }
            cell.prepareCellFor(enviromentCEll)
//            cell.defaultCell(self.defaultWeatherData)
//            cell.prepareCell(self.weatherModelData)
            cell.backgroundColor = .clear
            
            return cell
        }
        else if indexPath.row == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WheatherForcastingCell.indentifier, for: indexPath) as? WheatherForcastingCell else {
                return UITableViewCell()
            }
            
            cell.backgroundColor = .clear
            
            // MARK: - IBActions
            
            cell.watchForClickHandler { tag in
            
                //Implementation of Google Map
                
                if tag == 0 {
                    if let googleURL = URL(string:"comgooglemaps://") {
                        if UIApplication.shared.canOpenURL(googleURL) {
                            if let URLString = URL(string: "comgooglemaps://?center=\(71.587687),\(31.575)&zoom=16&views=traffic") {
                                UIApplication.shared.open(URLString, options: [:]) { isOpen in
                                    if isOpen {
                                        // print("Open in app")
                                    }
                                }
                                
                                //Alternative Way
                                
                            } else {
                                self.openBrowser()
                            }
                        } else {
                            self.openBrowser()
                        }
                    } else {
                        self.openBrowser()
                    }
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    private func openBrowser() {
        if let URLString = URL(string: "http://maps.google.com/maps?q=loc:\(71.587687),\(31.575)&zoom=14&views=traffic") {
            UIApplication.shared.open(URLString, options: [:]) { isOpen in
                if isOpen {
                    // print("Open in browser")
                }
            }
        }
    }
    
    //Assign Height to each Table Custom Cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 250
        } else if indexPath.row == 1 {
            return 60
        } else if indexPath.row == 2 {
            return 300
        } else if indexPath.row == 3 {
            return 50
        } else {
            return 100
        }
    }
}

//Extension for Table Scroll Function

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let item = scrollView as? UITableView {
            if item != tableView {
                return
            }
            
            // Getting frame size for table view
            let viewoffset = tableView.frame.size.height + tableView.frame.origin.y
            
            // on specific value adjust top View
            if scrollView.contentOffset.y > 10 {
                
                let size = 320 - scrollView.contentOffset.y
                if size > 170 {
                    adjustTopView(size, true)
                } else {
                    adjustTopView(170, true)
                }
                
            } else if scrollView.contentOffset.y <= 170 {
                
                adjustTopView(320, false)
                
            } else if viewoffset < scrollView.contentOffset.y {
                
                // expand the header
                adjustTopView(170, false)
                
            }
            
            // Animating while expanding top view
            UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

//Extension for Collection View

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        return CGSize(width: collectionView.bounds.width / 8.5 , height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


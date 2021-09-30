//
//  ViewController.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

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
        var timeCollectionCell = [WeatherRegardingTime]()
        var isTopHide = false
        var isTableViewScroll = false
        var imageview : UIImageView? = nil
        private var isScrollUp = false
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        var day = [String]()
        
        var defaultWeatherData = [WeatherDetail]()
        var locatonModelData = [LocationData]()
        var enviromentCEll = [Enviroment]()
        var dayWeather = [DayWiseData]()
        
        // MARK: - Constants
        
        // MARK: - View LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            
            getNextDate()
            
            // MARK: - API - Calling:
            DefaultLocationDetail()
            DefaultWeatherDetail()
            
            // MARK: -  Initialization code
            wheatherData()
            
            // MARK: -  Collection View Inshilization
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: CustomCollectionView.indentifier, bundle: nil),forCellWithReuseIdentifier: CustomCollectionView.indentifier)
            collectionView.updateFLow(itemSpacing: 5, lineSpacing: 5, true)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.clearBackground()
            
            // MARK: -  Table View Inshilization
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
        
        // MARK: - Custom Functions
        func locationDataPass(locationData: LocationData) {
            
            locationNameLbl.text =  locationData.title!
            
            print(locationData.woeid ?? "")
            self.locationSearch = locationData
            GetWeatherDetail()
        }
     
        //MARK: - Default Location Name API Func
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
        
        //MARK: - Default Location Detail API Func
        func DefaultWeatherDetail() {
            
            let requestURL = "https://www.metaweather.com/api/location/2211096"
            NetworkManager.shared.GetWeatherDetail(requestURL) { success, message, weather in
                if success {
                    if let weather = weather {
                        self.defaultWeatherData = weather
                        self.weatherDetail(extraDuplicateArr: self.defaultWeatherData)
                        self.defualtWeatherValue(defaultWeatherData: self.defaultWeatherData)
                        self.DayWiseWeather(extraDuplicateArr: self.defaultWeatherData)
                        self.tableView.reloadData()
                    }
                } else {
                    print(message)
                }
            }
        }
        
        //MARK: - Location Detail Api Func
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
                        self.DayWiseWeather(extraDuplicateArr: self.defaultWeatherData)
                        self.tableView.reloadData()
                    }
                } else {
                    print(message)
                }
            }
        }
        
        //MARK: - Default & API Data Append Func
        func weatherDetail(extraDuplicateArr: [WeatherDetail]) {
        
            enviromentCEll.removeAll()
            
            if extraDuplicateArr.count > 0 {
                
            enviromentCEll.append(Enviroment( sunrise: "SUNRISE", value: Double(extraDuplicateArr[0].min_temp!)))
            enviromentCEll.append(Enviroment( sunrise: "SUNSET", value: extraDuplicateArr[0].min_temp!))
            enviromentCEll.append(Enviroment( sunrise: "WIND", value: extraDuplicateArr[0].wind_speed!))
            enviromentCEll.append(Enviroment( sunrise: "HUMIDITY", value: extraDuplicateArr[0].humidity!))
            enviromentCEll.append(Enviroment( sunrise: "VISIBILITY", value: extraDuplicateArr[0].visibility!))
            enviromentCEll.append(Enviroment( sunrise: "PRESSURE", value: extraDuplicateArr[0].air_pressure!))
            enviromentCEll.append(Enviroment( sunrise: "DIRECTION", value: extraDuplicateArr[0].wind_direction!))
            enviromentCEll.append(Enviroment( sunrise: "PREDICTABILITY", value: extraDuplicateArr[0].predictability!))
           
            }
        }
        
        //MARK: - DayWise Weather Func
        func DayWiseWeather(extraDuplicateArr: [WeatherDetail]) {
            
            dayWeather.removeAll()
            
            dayWeather.append(DayWiseData(dayTitle: day[0], image: extraDuplicateArr[0].weather_state_abbr ?? "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[0].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[0].min_temp!)))
            dayWeather.append(DayWiseData(dayTitle: day[1], image: extraDuplicateArr[1].weather_state_abbr ?? "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[1].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[1].min_temp!)))
            dayWeather.append(DayWiseData(dayTitle: day[2], image: extraDuplicateArr[2].weather_state_abbr ?? "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[2].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[2].min_temp!)))
            dayWeather.append(DayWiseData(dayTitle: day[3], image: extraDuplicateArr[3].weather_state_abbr ?? "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[3].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[3].min_temp!)))
            dayWeather.append(DayWiseData(dayTitle: day[4], image: extraDuplicateArr[4].weather_state_abbr ?? "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[4].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[4].min_temp!)))
            dayWeather.append(DayWiseData(dayTitle: day[5], image: extraDuplicateArr[5].weather_state_abbr ?? "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[5].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[5].min_temp!)))
            dayWeather.append(DayWiseData(dayTitle: day[6], image: "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[0].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[0].min_temp!)))
            dayWeather.append(DayWiseData(dayTitle: day[7], image:  "",
                                          highTempTitle: String(format: "%.0f", extraDuplicateArr[0].max_temp!),
                                          lowTempTitle: String(format: "%.0f", extraDuplicateArr[0].min_temp!)))
            
        }
        
        //MARK: - Next Day Picker Function
        func getNextDate() {
             
            for i in (1..<9) {
                   
                    let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + i)
                    let dateTomorrow = Calendar.current.date(from: tomorrow)!
                    //print(dateTomorrow)
                    let date = dateTomorrow
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat  = "EEEE" // "EE" to get short style
                    let dayInWeek = dateFormatter.string(from: date)
                    print(dayInWeek)
                    day.append("\(dayInWeek)")
            }
        }
        
        //MARK: - Default City Name Func
        func defaultLocationAssign(LocatonModelData: [LocationData]) {
                
            locationNameLbl.text = LocatonModelData[0].title
        }
        
        //MARK: - Default City Weather Detail Func
        func defualtWeatherValue(defaultWeatherData: [WeatherDetail]){
            
            lowestTemp.text = String(format: "%.2f", defaultWeatherData[0].min_temp!)
            highestTemp.text = String(format: "%.2f", defaultWeatherData[0].max_temp!)
            degreeLabel.text = String(format: "%.0f", defaultWeatherData[0].the_temp!)
            weatherState.text = defaultWeatherData[0].weather_state_name
        }
        
        //MARK: - API City Weather Detail Func
        func assingningValue(weatherModelData: [WeatherDetail]) {

            lowestTemp.text = String(format: "%.2f", weatherModelData[0].min_temp!)
            highestTemp.text = String(format: "%.2f", weatherModelData[0].max_temp!)
            degreeLabel.text = String(format: "%.0f", weatherModelData[0].the_temp!)
            weatherState.text = weatherModelData[0].weather_state_name
        }

        //MARK: - Data for Weather time Collection View
        func wheatherData() {

            timeCollectionCell.append(WeatherRegardingTime(image: "sunny", topTitle: "Now", bottomTitle: "31"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunrise", topTitle: "1PM", bottomTitle: "31"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunny", topTitle: "2PM", bottomTitle: "32"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunset", topTitle: "3PM", bottomTitle: "32"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunny", topTitle: "4PM", bottomTitle: "31"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunrise", topTitle: "5PM", bottomTitle: "31"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunny", topTitle: "6PM", bottomTitle: "29"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunset", topTitle: "6PM", bottomTitle: "Sunset"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunny", topTitle: "7PM", bottomTitle: "29"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunset", topTitle: "8PM", bottomTitle: "28"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunny", topTitle: "9PM", bottomTitle: "27"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunrise", topTitle: "10PM", bottomTitle: "27"))
            timeCollectionCell.append(WeatherRegardingTime(image: "sunny", topTitle: "11PM", bottomTitle: "27"))
        }
        
        
        
        func adjustTopView(_ height: CGFloat, _ topHide: Bool ) {
            view.layoutIfNeeded()
            heightConstrain.constant = height
            isTopHide = topHide
        }
        
        // MARK: - IBAction
        @IBAction func searchBar(_ sender: UIButton) {
            
            let vc = self.storyboard?.instantiateViewController(identifier: "SearchBAr") as! SearchBAr
            vc.delegate = self
            self.navigationController?.pushViewController( vc , animated: true)
            
        }
    }

    // MARK: - Table View Extension
    extension ViewController: UITableViewDelegate, UITableViewDataSource  {
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCellTwo.indentifier, for: indexPath) as? CustomTableCellTwo else {
                    return UITableViewCell()
                }
                cell.prepareCell(dayWeather)
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
            return timeCollectionCell.count
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionView.indentifier , for: indexPath ) as? CustomCollectionView else {
                return UICollectionViewCell()
            }
            
            cell.prepare(timeCollectionCell[indexPath.row])
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


//
//  SearchBAr.swift
//  WheatherApp
//
//  Created by Apple on 16/09/2021.
//

import UIKit

protocol LocationDataPass {
    
    func locationDataPass(locationData: LocationData)
}

class SearchBAr: UIViewController {
    
    // MARK: - Identifier
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    var locationData = [LocationData]()
    var citySearch = [SearchBar]()
    var searching = false

    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    var delegate: LocationDataPass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialization code
        
        searchBar.placeholder = "Search"
        self.searchBar.layer.cornerRadius = 15 // I've tried other numbers besides this too with no luck
        self.searchBar.clipsToBounds = true
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: SearchTableView.indentifier, bundle: nil), forCellReuseIdentifier: SearchTableView.indentifier)
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
    }
    
    func GetLocationDetail() {
        let requestURL = "https://www.metaweather.com/api/location/search/?query=\(searchBar.text ?? "")"
        NetworkManager.shared.GetLocationDetail(requestURL) { success, message, location in
            if success {
                if let location = location {
                    self.locationData = location
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } else {
                print(message)
            }
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func cancelBtn(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
}

    // MARK: - Table View Extension
    extension SearchBAr: UITableViewDelegate, UITableViewDataSource  {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableView.indentifier, for: indexPath) as? SearchTableView else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "\(locationData[indexPath.row].title ?? "")"
        cell.backgroundColor = .clear
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let locationData = locationData[indexPath.row]
        
        delegate.locationDataPass(locationData: locationData)
        navigationController?.popViewController(animated: true)
    }
}

  // MARK: - SearchBar View Extension
  extension SearchBAr: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchBar.showsCancelButton = false
        if searchBar.text != "" {
            GetLocationDetail()
        }
    }
}

//
//  wheatherViewModel.swift
//  WheatherApp
//
//  Created by Apple on 20/09/2021.
//

import UIKit

class wheatherViewModel{
   
    
  weak var vc: ViewController?
  var arrUsers = [weatherModel]()
     
  func weatherData() {
    URLSession.shared.dataTask(with: URL(string: "https://www.metaweather.com/api/location/2211177")!) { (data, reponse, error)
           
        in
            if error == nil {
                if let data = data {
                    do{
                        let userResponse = try JSONDecoder().decode(weatherModel.self, from: data)
                        print(userResponse)
                    } catch let err{
                        print(err.localizedDescription)
                    }
                }
            } else {
                print(error?.localizedDescription)
            }
        }.resume()
    }
}


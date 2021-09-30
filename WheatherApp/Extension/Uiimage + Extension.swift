//
//  Uiimage + Extension.swift
//  WheatherApp
//
//  Created by Apple on 29/09/2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(_ url: String) {
            self.kf.indicatorType = .activity
            let baseUrl = "https://www.metaweather.com/static/img/weather/png/"
            let imageFormate = ".png"
            let imageUrl = URL(string: baseUrl + url + imageFormate)
            print(imageUrl)
        self.kf.setImage(with: imageUrl, placeholder: UIImage(named: "loading"))
        }
}

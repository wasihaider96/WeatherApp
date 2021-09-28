//
//  NetworkManager.swift
//  WheatherApp
//
//  Created by Apple on 17/09/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

// TypeAlias Location Completion Handler

typealias LocationCompletionNetwork = ( _ success: Bool, _ message: String, _ location: [LocationData]?) -> Void

// TypeAlias Location Weather handler

typealias WeatherCompletionNetwork = ( _ success: Bool, _ message: String, _ weather: [weatherModel]?) -> Void

class NetworkManager {
    
    // Shared Instance
    
    static let shared = NetworkManager()
    
    // Shared Methods
    
    func GetLocationDetail(_ url: String, completion: @escaping LocationCompletionNetwork) {
        // 1199477
        AF.request(url, method: .get).response { response in
            self.LocationhandleResponse(response, completion: completion)
        }
    }
    
    private func LocationhandleResponse(_ response: AFDataResponse<Data?>, completion: @escaping LocationCompletionNetwork) {
        switch response.result {
            case .success(let res):
                if let data = res, let code = response.response?.statusCode {
                    self.LocationparseResponse(data, code, completion: completion)
                }
            case .failure(let error):
                print(error.localizedDescription)
        }
    }
    
    private func LocationparseResponse(_ data: Data, _ code: Int, completion: @escaping LocationCompletionNetwork) {
        let json = JSON(data)
        
        if LocationcheckStatus(code) {
            let location = try? JSONDecoder().decode([LocationData].self, from: data)
            completion(true, json["detail"].stringValue, location)
            
        } else {
            completion(false, json["detail"].stringValue, nil)
        }
    }
     
    private func LocationcheckStatus(_ code: Int) ->  Bool {
        return code == 200
    }
    
    //Weather Details
    
    func GetWeatherDetail(_ url: String, completion: @escaping WeatherCompletionNetwork) {
        
        AF.request(url, method: .get).response { response in
            self.WeatherhandleResponse(response, completion: completion)
        }
    }
    
    private func WeatherhandleResponse(_ response: AFDataResponse<Data?>, completion: @escaping WeatherCompletionNetwork) {
        switch response.result {
            case .success(let res):
                if let data = res, let code = response.response?.statusCode {
                    self.WeatherparseResponse(data, code, completion: completion)
                }
            case .failure(let error):
                print(error.localizedDescription)
        }
    }
    
    private func WeatherparseResponse(_ data: Data, _ code: Int, completion: @escaping WeatherCompletionNetwork) {
        let json = JSON(data)
        let consolidatedWeather = json["consolidated_weather"]
        guard let rawData = try? consolidatedWeather.rawData() else {
            return
        }
        if WeathercheckStatus(code) {
            let weather = try? JSONDecoder().decode([weatherModel].self, from: rawData)
            completion(true, json["detail"].stringValue, weather)
            
        } else {
            completion(false, json["detail"].stringValue, nil)
        }
    }
    
    private func WeathercheckStatus(_ code: Int) ->  Bool {
        return code == 200
    }
}


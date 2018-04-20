//
//  APIRequests.swift
//  WeatherDemo
//
//  Created by Ali Jaber on 4/19/18.
//  Copyright © 2018 Ali Jaber. All rights reserved.
//

import Foundation
import Alamofire

// MARK: URLStrings
enum APIStrings {
    static let getWeatherURL = "http://api.openweathermap.org/data/2.5/forecast?"
}

class APIRequest {
    // MARK: BaseRequest
    fileprivate static func request (urlString: String!, parameters: Parameters?, method: HTTPMethod, headers: HTTPHeaders?, completion: @escaping(Bool, Error?, String?, DataResponse<Any>?) ->()) {
        Alamofire.request(urlString, method: method, parameters: parameters, headers: headers).responseJSON { (response) in
            let success = checkIfSuccess(response: response)
            if(success){
                completion(success, nil, nil, response)
            } else {
                completion(success, response.error, "Failed", nil)
            }
        }
    }

    // MARK: check if sucess Method
    fileprivate static func checkIfSuccess(response:DataResponse<Any>!) -> Bool {
        if let responseDict = response.result.value as? [String: Any] {
            print(responseDict)
            if let status = responseDict["cod"] as? String {
                return true
            }
            else {
                return false
            }
        } else {
            return false
        }
    }

    // MARK: Get WeatherData By Location
    static func getWeatherByLocation(latitude: String?, longitude: String? , completion: @escaping (Bool, String?, AllWeatherJson?)->()){
        let parameters = ["lat": latitude!,"lon": longitude!, "appId":"325095d3cda8d2c15aa8d6c64544dcdc"] as [String: Any]
        request(urlString: APIStrings.getWeatherURL, parameters: parameters, method: .get,  headers: nil) {(success, error, errorMsg, response) in
            if success {
                guard let dataDictionary = response?.result.value as? [String: Any] else {
                    return
                }
                let data = AllWeatherJson.init(with: dataDictionary["list"] as! [Any])
                completion(true, nil, data)
            } else {
                completion(false, response?.result.error as? String, nil)
            }
        }
    }
        
}


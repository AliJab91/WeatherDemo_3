//
//  WeatherJson.swift
//  WeatherDemo
//
//  Created by Ali Jaber on 4/19/18.
//  Copyright © 2018 Ali Jaber. All rights reserved.
//

import Foundation
// MARK: Combinig The ListArray
struct AllWeatherJson {
    var allLists: Array<WeatherList>?
    
    init(with json: Array<Any>) {
        var tempArray = Array<WeatherList>()
        for data in json {
            let setup = WeatherList.init(with: data as! Dictionary<String,Any>)
            tempArray.append(setup)
        }
        allLists = Array<WeatherList>.init(tempArray)
    }
}

// MARK: Weather List Array

struct WeatherList {
    var date: String?
    var mainInfo : MainInfo
    var mainWeather : Array<MainWeather>?
    init(with json: Dictionary<String,Any>) {
        date = json["dt_txt"] as? String
        if let dataArray = json["weather"] as? [Any] {
                            var allArray = Array<MainWeather>()
                            for data in dataArray {
                                let setup = MainWeather.init(with: data as! Dictionary<String,Any>)
                               allArray.append(setup)
                           }
                mainWeather = Array<MainWeather>.init(allArray)
                   }
         mainInfo = MainInfo.init(with: (json["main"] as? Dictionary<String,Any>)!)
    }
}

// MARK: Main Info Object
struct MainInfo {
    var temperature : Double?
    init(with json:Dictionary<String,Any>) {
        temperature = json["temp"] as? Double
    }
}

// MARK: Main Weather Object
    struct MainWeather {//array
        var weatherDescript : String?
        init(with json:Dictionary<String,Any>) {
            weatherDescript = json["description"] as? String
        }
    }


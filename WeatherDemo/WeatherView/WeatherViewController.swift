//
//  WeatherViewController.swift
//  WeatherDemo
//
//  Created by Ali Jaber on 4/19/18.
//  Copyright © 2018 Ali Jaber. All rights reserved.
//

import UIKit
import CoreLocation
class WeatherViewController: BaseViewController {
    /// Label displaying the welcome text
    @IBOutlet weak var welcomeLabel: UILabel!
    /// TableView displaying the retrieved data form server
    @IBOutlet weak var tableView: UITableView!
    /// Array holding retrieved data
    var receivedWeatherData = Array<Any>()
    /// getting the location of the user to send it to the server
    var locationManager = CLLocationManager()
    /// user location containing latitude and longitude
    var userLocation = CLLocation()
    var userLatitude : String!
    var userLongitude : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupTableView()
        setWelcomeLabelText()
        //getWeatherData()
    }

     // MARK: Setup WelcomeLabel
    func setWelcomeLabelText() {
        if let username = UserDefaults.standard.object(forKey: "usersName") {
            welcomeLabel.text = "Hi \(username),\nhere's is the weather :"
        }
    }

    // registering the cell in the tablleView + setting estimated row height
     // MARK: setUp Tableview
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"WeatherDetailsCell",bundle : nil), forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension

    }
 // MARK:setLocationManager
    //setting the location manager
    func setupLocationManager()  {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
     // MARK: Launching Request
    // launching loader, getting users latitude and longitude, check their values, and launch the request, if success, reload the tableview, else, display the error message
    func getWeatherData()  {
        self.showLoader()
        let latit = userLocation.coordinate.latitude
        let longit = userLocation.coordinate.longitude
        if latit == 0 {
            userLatitude = String(33.829233)
            userLongitude = String(35.512215)
        } else {
            userLatitude = String(latit)
            userLongitude = String(longit)
        }
        APIRequest.getWeatherByLocation(latitude: userLatitude, longitude: userLongitude) { (success, errorr, allWeatherJson) in
            self.hideLoader()
            if success {
                if let allData =  allWeatherJson?.allLists  {
                    self.receivedWeatherData = allData
                    self.tableView.reloadData()
                }
            } else {
                if let errorString = errorr {
                    self.displayAlert(title: "Error", message: errorString)
                } else {
                    self.displayAlert(title: "Error", message: "Something went wrong")
                }
            }
        }
    }
    // MARK: Date formatter function
    func dateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        var finalDate : String!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Source Date Format
        let date2 = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EEEE d MMM" //Destination Date Format
        let convDate = dateFormatter.string(from: date2!)
        finalDate = convDate
        return finalDate

    }
}

// MARK: LocationManager Delegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if userLocation.coordinate.latitude != 0 {
            return
        }else {
            let location = locations[0]
            userLocation = location
            getWeatherData()
        }
    }
}
// MARK: tableview functions
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherDetailsCell
        if let weatherToday = self.receivedWeatherData[indexPath.row] as? WeatherList, let mainWeather = weatherToday.mainWeather?[0], let date = weatherToday.date, let temperature = weatherToday.mainInfo.temperature {
            cell.weatherDate.text = dateFormatter(date: date)
            cell.weatherType.text = mainWeather.weatherDescript
            cell.weatherDegree.text = String(temperature) + "°F"
        }
        return cell
    }
    // setting the number of rows with respect to the size of the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.receivedWeatherData.count
    }
}

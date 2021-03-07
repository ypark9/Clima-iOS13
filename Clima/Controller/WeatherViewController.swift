//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherModel : WeatherModel?
    var locationManager  = CLLocationManager()
    var climaBrain = ClimaBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        climaBrain.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let cityname = searchTextField.text {
            print("City name entered : \(cityname)")
            climaBrain.city = cityname
            climaBrain.fetchWeather()
        }
        searchTextField.endEditing(true)
    }
    
    @IBAction func getCurrWeatherFromLocation(_ sender: UIButton) {
        climaBrain.fetchWeather(lat: climaBrain.lat, lon: climaBrain.lon)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""
        {
            return true
        }
        else {
            searchTextField.placeholder = "Please type the city"
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) // this calls textFieldDidEndEditing method. huh
        //print(searchTextField.text)
        return true // means we accept the value in text field
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            climaBrain.city = city
            climaBrain.fetchWeather()
        }
        searchTextField.text = ""
    }

    func didUpdateWeather(weather: WeatherModel) {
        weatherModel = weather
        if let weather = weatherModel {
            DispatchQueue.main.async {
                self.temperatureLabel.text = weather.tempatureString;
                self.conditionImageView.image = UIImage(systemName: weather.condtionName)
                self.cityLabel.text = weather.cityName
            }
        }
    }

    // an idea how to get the activated text field.
    //    func getSelectedTextField() -> UITextField? {
    //
    //        let totalTextFields = getTextFieldsInView(view: self)
    //
    //        for textField in totalTextFields{
    //            if textField.isFirstResponder{
    //                return textField
    //            }
    //        }
    //
    //        return nil
    //
    //    }
}

extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            print("lattitue : \(lat), long : \(long)")
            climaBrain.lat = lat
            climaBrain.lon = long
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get the location: + \(error)")
    }
}

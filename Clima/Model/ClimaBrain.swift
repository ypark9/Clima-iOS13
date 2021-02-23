//
//  ClimaBrain.swift
//  Clima
//
//  Created by Yoonsoo Park on 2/5/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct ClimaBrain {
    var city = ""
    var appID = MyOpenWeatherApiKey
    var delegate : WeatherDelegate?
    //http://api.openweathermap.org/data/2.5/weather?q=new%20york&appid=
    func fetchWeather() {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=imperial&appid=\(appID)"
        print("Before requesting : \(urlString)")
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String) {
        //1. create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task. learn about the call back.
            let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
                                            if error != nil {
                                                print(error!)
                                                return
                                            }
                                            
                                            if let safeData = data {
//                                                let dataString = String(data: safeData, encoding: .utf8)
//                                                print(dataString)
                                                if let weather = parseJSON(weatherData : safeData) {
                                                    delegate?.didUpdateWeather(weather : weather)
                                                }
                                            }})
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.name)
//            print(decodedData.weather[0].description)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            print(error)
            return nil
        }
    }

//    func handle(data : Data?, response : URLResponse?, error: Error?){
//        //check it is error free
//        if error != nil {
//            print(error!)
//            return
//        }
//
//        if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8)
//            print(dataString)
//        }
//    }
}


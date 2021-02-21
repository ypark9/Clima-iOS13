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
    
    //http://api.openweathermap.org/data/2.5/weather?q=new%20york&appid=
    func fetchWeather() {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appID)"
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
                                                let dataString = String(data: safeData, encoding: .utf8)
                                                print(dataString)
                                            }})
            //4. Start the task
            task.resume()
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

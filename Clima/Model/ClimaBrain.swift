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
    func makeOpenWeatherQueryURL() -> String {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appID)"
        return url
    }
}

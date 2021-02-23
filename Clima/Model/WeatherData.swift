//
//  WeatherData.swift
//  Clima
//
//  Created by Yoonsoo Park on 2/20/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let name : String
    let main : Main
    let weather : Array<Weather> //[Weather]
}

struct Main : Decodable {
    let temp : Double
}

struct Weather : Decodable {
    let id : Int
    let description : String
}

//
//  WeatherDelegate.swift
//  Clima
//
//  Created by Yoonsoo Park on 2/22/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherDelegate: AnyObject {
    func didUpdateWeather(weather : WeatherModel)
}

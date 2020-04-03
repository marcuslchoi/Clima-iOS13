//
//  WeatherData.swift
//  Clima
//
//  Created by Marcus Choi on 4/2/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//structs for dealing with JSON data
struct WeatherData:Codable
{
    let name:String
    let main:Main
    let weather: [WeatherProperties]
}

//see the weather data JSON format
struct Main:Codable
{
    let temp:Double
}

struct WeatherProperties:Codable
{
    let id:Int
    let description:String
}

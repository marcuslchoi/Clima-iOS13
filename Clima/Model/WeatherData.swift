//
//  WeatherData.swift
//  Clima
//
//  Created by Marcus Choi on 4/2/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//structs for dealing with JSON data
struct WeatherData:Decodable
{
    let name:String
    let main:Main
    let weather: [WeatherProperties]
}

//see the weather data JSON format
struct Main:Decodable
{
    let temp:Double
}

struct WeatherProperties:Decodable
{
    let id:Int
    let description:String
}

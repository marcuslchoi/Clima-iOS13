//
//  WeatherManager2.swift
//  Clima
//
//  Created by Marcus Choi on 4/1/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=d655f558ea04d2b06dd81edb00d41ef8&units=imperial"
    
    static var instance = WeatherManager()
    private init()
    {}
    
    func getWeather(_ city:String)
    {
        let url = baseUrl + "&q=\(city)"
        //print(url)
        performRequest(url)
    }
    
    func performRequest(_ urlString: String)
    {
        //optional binding
        if let url = URL(string: urlString)
        {
            //create URL session
            //like a browser (performs the networking)
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url, completionHandler: handleData(data:response:error:))
            task.resume()
        }
    }
    
    func handleData(data:Data?, response:URLResponse?, error:Error?)
    {
        if(error != nil)
        {
            print(error)
            return
        }
        if let safeData = data
        {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
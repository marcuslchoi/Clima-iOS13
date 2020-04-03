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
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                if(error != nil)
                {
                    print(error)
                    return
                }
                if let safeData = data
                {
                    self.parseJSON(data: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data:Data)
    {
        let decoder = JSONDecoder()
        
        do
        {
            //since decode can throw an error, must be in "do block" with try and catch
            //WeatherData.self refers to the WeatherData type
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let conditionId = decodedData.weather[0].id
            
            let weatherObj = WeatherModel(conditionId: conditionId, cityName: name, temperature: temp)
            let conditionName = weatherObj.conditionName

            print(conditionName)
        } catch {
            print(error)
        }
    }
    
    
}

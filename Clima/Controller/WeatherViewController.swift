//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherManager.instance.delegate = self
        //current view controller is now notified when events happen with this text field
        searchTextField.delegate = self
    }

    //d655f558ea04d2b06dd81edb00d41ef8

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(searchTextField.text == "")
        {
            
            searchTextField.placeholder = "type something!"
            return false
        }
        else
        {
            return true
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //searchTextField.text = ""
        if let city = searchTextField.text{
            WeatherManager.instance.getWeather(city)
        }
    }
    
    //conform to WeatherManagerDelegate protocol
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weatherModel: WeatherModel) {
        print(weatherModel.conditionName)
    }
}


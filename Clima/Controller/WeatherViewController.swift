//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        WeatherManager.instance.delegate = self
        //current view controller is now notified when events happen with this text field
        searchTextField.delegate = self
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last
        {
            let lat = Double(location.coordinate.latitude)
            let lon = Double(location.coordinate.longitude)
            WeatherManager.instance.getWeather(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate
{
    //conform to WeatherManagerDelegate protocol
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weatherModel: WeatherModel) {
        print(weatherModel.conditionName)
        //must invoke on main thread since this function is called while networking (run on bg thread)
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(weatherModel.temperature)
            self.conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
        }
    }
    
    //conform to WeatherManagerDelegate protocol
    func didFailWithError(_ weatherManager:WeatherManager, _ error: Error) {
        print(error)
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController:UITextFieldDelegate
{
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
    
}


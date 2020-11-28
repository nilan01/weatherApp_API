//
//  WeatherDetailViewController.swift
//  weatherApp_API
//
//  Created by user182271 on 11/28/20.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    var weatherObj :  Weather = Weather(temp: 0.0, humidity: 0);
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        humidityLabel.text = "\(weatherObj.humidity)"
        tempLabel.text = "\(weatherObj.temp)"
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

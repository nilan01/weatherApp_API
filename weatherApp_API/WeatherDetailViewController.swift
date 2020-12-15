//
//  WeatherDetailViewController.swift
//  weatherApp_API
//
//  Created by user182271 on 11/28/20.
//

import UIKit
import Alamofire

class WeatherDetailViewController: UIViewController, IconServiceDelegate{
    
    var model = Model()
    
    func iconServiceDelegateDidFinishWithData(result: Data) {
        print("THIS IS IN DETAILS", result)
        DispatchQueue.main.async {
            self.weatherIcon.image = UIImage(data: result)
            //print(result)
        }
    }
    
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var weatherMain: UILabel!
    @IBOutlet weak var weatherFeels: UILabel!
    
    lazy var myService : Service = {
        let service = Service()
        return service
    }()
    
    var valueFromLocationsArray : [Location] = []
    var weatherObj :  Weather = Weather(temp: 0.0, humidity: 0, icon: "", desc: "", main: "", feelsLike: 0.0);
    var iOD : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        self.navigationItem.title = model.getCity
        myService.delegate3 = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myService.fetchFromWeather(key: "\(model.getCity)"){(weather, weather2, weather3, weather4, weather5, weather6) in
            var icon : String = ""
            var desc : String = ""
            var main : String = ""
            
            for name in weather3{
                icon = name as! String
                self.myService.fetchFromWeatherIcon(key: icon){(weather) in
                    DispatchQueue.main.async{
                        self.weatherIcon.image = UIImage(data: weather)
                    }
                }
            }
            for x in weather4{
                desc = x as! String
            }
            for x in weather5{
                main = x as! String
            }
            
            let celWeather : Int = Int(Double(Int(weather)) - 273.15 + 0.5)
            let feelsWeather : Int = Int(Double(Int(weather6)) - 273.15 + 0.5)
            self.weatherObj.temp = Double(celWeather)
            self.weatherObj.humidity = weather2
            self.weatherObj.icon = icon
            self.weatherObj.desc = desc
            self.weatherObj.main = main
            self.weatherObj.feelsLike = Double(feelsWeather)
            DispatchQueue.main.async {
                self.humidityLabel.text = "\(self.weatherObj.humidity)%"
                self.tempLabel.text = "\(self.weatherObj.temp)°"
                self.weatherDesc.text = "\(self.weatherObj.desc)"
                self.weatherMain.text = "\(self.weatherObj.main)"
                self.weatherFeels.text = "\(self.weatherObj.feelsLike)°"
            }
        }
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

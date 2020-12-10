//
//  WeatherDetailViewController.swift
//  weatherApp_API
//
//  Created by user182271 on 11/28/20.
//

import UIKit

class WeatherDetailViewController: UIViewController, IconServiceDelegate{
    
    var model = Model()
    
    func iconServiceDelegateDidFinishWithData(result: Data) {
        //print(result)
        DispatchQueue.main.async {
            self.weatherIcon.image = UIImage(data: result)
        }
    }
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    lazy var myService : Service = {
        let service = Service()
        service.delegate3 = self
        return service
    }()
    
    var valueFromLocationsArray : [Location] = []
    var weatherObj :  Weather = Weather(temp: 0.0, humidity: 0, icon: "");
    var iOD : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        self.navigationItem.title = model.getCity
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myService.fetchFromWeatherIcon(key: weatherObj.icon){(weather) in
            //print(weather)
            //self.weatherIcon.image = weather as! UIImage
        }
        myService.fetchFromWeather(key: "\(model.getCity)"){(weather, weather2, weather3) in
            //print(weather)
            var celWeather : Int = Int(Double(Int(weather)) - 273.15 + 0.5)
            self.weatherObj.temp = Double(celWeather)
            self.weatherObj.humidity = weather2
            DispatchQueue.main.async {
                self.humidityLabel.text = "\(self.weatherObj.humidity)"
                self.tempLabel.text = "\(self.weatherObj.temp)"
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

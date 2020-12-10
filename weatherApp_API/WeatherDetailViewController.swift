//
//  WeatherDetailViewController.swift
//  weatherApp_API
//
//  Created by user182271 on 11/28/20.
//

import UIKit

class WeatherDetailViewController: UIViewController, IconServiceDelegate{
    func iconServiceDelegateDidFinishWithData(result: Data) {
        print(result)
        DispatchQueue.global().async {
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
        
        humidityLabel.text = "\(weatherObj.humidity)"
        tempLabel.text = "\(weatherObj.temp)"
        self.navigationItem.title = valueFromLocationsArray[iOD].city
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myService.fetchFromWeatherIcon(key: weatherObj.icon){(weather) in
            //print(weather)
            //self.weatherIcon.image = weather as! UIImage
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

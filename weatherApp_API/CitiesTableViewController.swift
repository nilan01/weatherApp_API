//
//  CitiesTableViewController.swift
//  weatherApp_API
//
//  Created by user182271 on 11/27/20.
//

import UIKit

class CitiesTableViewController: UITableViewController, WeatherServiceDelegate {
    
    var weather1 : Weather = Weather(temp: 0, humidity: 0)

    
    
    func weatherServiceDelegateDidFinishWithData(result: Double, result2: Int) {
        weather1.humidity = result2
        weather1.temp = result
        //setWeather(r: result, r1: result2)
    }

    lazy var myService : Service = {
        let service = Service()
        service.delegate2 = self
        return service
    }()
    
    func fetchAllLocations(){
        allLocations = CoreDataManager.shared.fetchLocationsFromCoreData()
        tableView.reloadData()
    }

    var allLocations = [Location]()
    

    override func viewWillAppear(_ animated: Bool) {
        fetchAllLocations()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllLocations()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

        cell.textLabel?.text = allLocations[indexPath.row].city
        cell.detailTextLabel?.text = allLocations[indexPath.row].country
        return cell
    }
    
    var i = 0;
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myService.fetchFromWeather(key: "\(allLocations[indexPath.row].city!)"){(weather, weather2) in
            print(weather)
            self.weather1.temp = weather
            self.weather1.humidity = weather2
        }
        let selectedOrder = self.allLocations[indexPath.row]
        i = indexPath.row
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "locationsSegue"){
            let history : LocationsTableViewController = segue.destination as! LocationsTableViewController
        }else{
            let weatherDetails : WeatherDetailViewController = segue.destination as! WeatherDetailViewController
            weatherDetails.weatherObj = weather1
            print(weather1.humidity)
            let locations : [Location] = allLocations
            weatherDetails.valueFromLocationsArray = locations
            weatherDetails.iOD = i
        }
    }
}

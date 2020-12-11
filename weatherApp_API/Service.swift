//
//  Service.swift
//  weatherApp_API
//
//  Created by user182271 on 11/26/20.
//

import Foundation

protocol ServiceDelegate {
    func serviceDelegateDidFinishWithData(location : Location)
    func serviceDelegateDidFinishWithDictinary(result : [String])
}

protocol WeatherServiceDelegate{
    func weatherServiceDelegateDidFinishWithData(result : Double, result2 : Int, result3 : NSArray, result4: NSArray, result5: NSArray, result6: Double)
}
protocol IconServiceDelegate{
    func iconServiceDelegateDidFinishWithData(result: Data)
    
}
class Service{
    static var shared = Service()

    var delegate : ServiceDelegate?
    var delegate2 : WeatherServiceDelegate?
    var delegate3: IconServiceDelegate?
    
    func fetchFromYahoo(key :String , handler : @escaping ([String])->Void) {
         guard let myUrl = URL(string: "http://gd.geobytes.com/AutoCompleteCity?callback=&q=\(key)") else {return}
        URLSession.shared.dataTask(with: myUrl) { (data, request, error) in
         
            if let _ = error {return}
            guard let httpResponse = request as? HTTPURLResponse,
                                                    (200...299).contains(httpResponse.statusCode)
                                                    else {
                                                        // Show the URL and response status code in the debug console
                                                        if let httpResponse = request as? HTTPURLResponse {
                                                            print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                                                        }
                                                        return
                                                }
                      if let myData = data{
                        do {
                       let jsonObject = try JSONSerialization.jsonObject(with: myData, options: []) as! [String]
                            let listOfLocations = jsonObject.flatMap({$0.components(separatedBy: "\",")})
                            
                            self.delegate?.serviceDelegateDidFinishWithDictinary(result: listOfLocations)
                            
                            handler(listOfLocations)
                        }catch {
                            
                        }
            }
        }.resume()
    }
    
    func fetchFromWeather(key : String , handler : @escaping (Double, Int, NSArray, NSArray, NSArray, Double)->Void) {
         guard let myUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(key)&appid=1d0c090ca206ea5b434cdfbced7aa471") else {return}
        URLSession.shared.dataTask(with: myUrl) { (data, request, error) in
            if let _ = error {return}
            guard let httpResponse = request as? HTTPURLResponse,
                                                    (200...299).contains(httpResponse.statusCode)
                                                    else {
                                                        // Show the URL and response status code in the debug console
                                                        if let httpResponse = request as? HTTPURLResponse {
                                                            print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                                                        }
                                                        return
                                                }
                      if let myData = data{
                        do {
                       let jsonObject = try JSONSerialization.jsonObject(with: myData, options: []) as! NSDictionary
                            print(jsonObject)
                            let listOfStock = jsonObject.value(forKeyPath: "main.temp") as! Double
                            
                            let listOfStock2 = jsonObject.value(forKeyPath: "main.humidity") as! Int
                            let listOfStock3 = jsonObject.value(forKeyPath: "weather.icon") as! NSArray
                            
                            let listOfStock4 = jsonObject.value(forKeyPath: "weather.description") as! NSArray
                            let listOfStock5 = jsonObject.value(forKeyPath: "weather.main") as! NSArray
                            
                            let listOfStock6 = jsonObject.value(forKeyPath: "main.feels_like") as! Double
                            self.delegate2?.weatherServiceDelegateDidFinishWithData(result: listOfStock, result2: listOfStock2, result3: listOfStock3, result4: listOfStock4, result5: listOfStock5, result6: listOfStock6)
                            
                            handler(listOfStock, listOfStock2, listOfStock3, listOfStock4, listOfStock5, listOfStock6)
                        }catch {
                        
                        }
            }
        }.resume()
    }
    
    func fetchFromWeatherIcon(key : String , handler : @escaping (Data)->Void) {
         guard let myUrl = URL(string: "http://openweathermap.org/img/wn/\(key)@2x.png") else {return}
        URLSession.shared.dataTask(with: myUrl) { (data, request, error) in
            if let _ = error {return}
            guard let httpResponse = request as? HTTPURLResponse,
                                                    (200...299).contains(httpResponse.statusCode)
                                                    else {
                                                        // Show the URL and response status code in the debug console
                                                        if let httpResponse = request as? HTTPURLResponse {
                                                            print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                                                        }
                                                        return
                                                }
                      if let myData = data{
                        do {
                            print(myData)
                            self.delegate3?.iconServiceDelegateDidFinishWithData(result : myData)
                            handler(myData)
                        }catch {
                            
                        }
            }
        }.resume()
    }
}

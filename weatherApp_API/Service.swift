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
    func weatherServiceDelegateDidFinishWithData(result : Double, result2 : Int, result3 : NSObject)
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
                            //objective c dictianry is untyped
                            //for var i in jsonObject{
                             //   print(i)
                            //}
                            /*let index = jsonObject.firstIndex(of: ",");
                            let city = jsonObject[..<index!]
                            print(city)*/
                            //print(jsonObject)
                            let listOfLocations = jsonObject.flatMap({$0.components(separatedBy: "\",")})
                            //print(listOfLocations[0])
                            
                            self.delegate?.serviceDelegateDidFinishWithDictinary(result: listOfLocations)
                            
                            handler(listOfLocations)
                        }catch {
                            
                        }
                        
            }
        }.resume()
    }
    
    func fetchFromWeather(key : String , handler : @escaping (Double, Int, NSObject)->Void) {
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
                            let listOfStock = jsonObject.value(forKeyPath: "main.temp") as! Double
                            //print(jsonObject)
                            let listOfStock2 = jsonObject.value(forKeyPath: "main.humidity") as! Int
                            let listOfStock3 = jsonObject.value(forKeyPath: "weather.icon") as! NSObject
                            //print(listOfStock3)
                            //print(listOfStock)
                            
                            self.delegate2?.weatherServiceDelegateDidFinishWithData(result: listOfStock, result2: listOfStock2, result3: listOfStock3)
                            
                            handler(listOfStock, listOfStock2, listOfStock3)
                        }catch {
                            
                        }
            }
        }.resume()
    }
    
    func fetchFromWeatherIcon(key : String , handler : @escaping (Data)->Void) {
        //print("This is the key: " + key.description)
         guard let myUrl = URL(string: "http://openweathermap.org/img/wn/01d@2x.png") else {return}
        URLSession.shared.dataTask(with: myUrl) { (data, request, error) in
         //print(data)
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
                            //print(myData)
                       //let jsonObject = try JSONSerialization.jsonObject(with: myData, options: []) as! NSDictionary
                            //let listOfStock = jsonObject.value(forKeyPath: "main.temp") as! Any
                            print(myData)
                            //print(jsonObject)
                            //print(listOfStock)
                            //print(myData)
                            self.delegate3?.iconServiceDelegateDidFinishWithData(result : myData)
                            handler(myData)
                        }catch {
                            
                        }
            }
        }.resume()
    }
}

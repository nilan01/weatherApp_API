//
//  Model.swift
//  weatherApp_API
//
//  Created by user182271 on 11/27/20.
//

import Foundation

struct Loca{
    var cty : String;
    var ctry : String;
}

struct Weather{
    var temp: Double;
    var humidity: Int;
    var icon : String;
    var desc : String;
    var main : String;
    var feelsLike : Double;
}

class Model{
    var getCity : String = ""
}

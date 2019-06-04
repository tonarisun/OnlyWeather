//
//  City.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class City: Equatable {
    
    let cityID : String
    let cityName : String
    let cityNameRUS : String
    let country : String
    var isAdded : Bool
    
    init(cityID: String, cityName: String, cityNameRUS: String, country: String, isAdded: Bool) {
        self.cityID = cityID
        self.cityName = cityName
        self.cityNameRUS = cityNameRUS
        self.country = country
        self.isAdded = isAdded
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
       return lhs.cityID == rhs.cityID
    }

//    
//    required init?(map: Map) {
//    }
//    
//    func mapping(map: Map) {
//        cityID <- map["id"]
//        cityName <- map["name"]
//        country <- map["country"]
//        lattitude <- map["coord.lat"]
//        longitude <- map["coord.lon"]
//    }
}

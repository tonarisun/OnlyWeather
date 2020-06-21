//
//  CurrentTimeZone.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 21.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class CurrentTimezone: Mappable {
    
    var timezone = 0

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        timezone <- map["timezone"]
    }
}

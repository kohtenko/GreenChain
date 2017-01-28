//
//  Device.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import SwiftyJSON

enum DeviceType: String {
    case solar = "Solar Panel"
    case wind = "Wind Turbine"

    var icon: UIImage? {
        switch self {
        case .solar:
            return UIImage(named: "sun_icon")
        case .wind:
            return UIImage(named: "wind_icon")
        }
    }
}

class Device {

    var id: String
    var name: String
    var type: DeviceType
    var energyValues: [Int]?

    init(with json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        type = json["type"].stringValue == "type1" ? .solar : .wind
    }
}

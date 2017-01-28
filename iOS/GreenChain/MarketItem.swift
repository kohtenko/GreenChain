//
//  MarketItem.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit
import SwiftyJSON

class MarketItem {

    var title: String!
    var subtitle: String!
    var image: UIImage?
    var price: Int!
    var detailsValues: [String : String]?
    var description: String!

    init(with json: JSON) {
        title = json["title"].stringValue
        subtitle = json["subtitle"].stringValue
        image = UIImage(named: json["image"].stringValue)
        price = json["price"].intValue
        description = json["description"].stringValue
        if !json["details"].isEmpty {
            detailsValues = [String : String]()
            for (key,subJson):(String, JSON) in json["details"] {
                detailsValues?[key] = subJson.stringValue
            }
        }
    }

    func key(at index: Int) -> String {
        return detailsValues?.keys.sorted()[index] ?? ""
    }

}

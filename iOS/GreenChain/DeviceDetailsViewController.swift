//
//  DeviceDetailsViewController.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DeviceDetailsViewController: UIViewController {

    var device: Device!

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(BASE_URL + "device/energy/" + device.id).responseJSON { (response) in
            let json = JSON(data: response.data!)
            self.device.energyValues = []
            for (_, subJson):(String, JSON) in json["energy"] {
                self.device.energyValues?.append(subJson.intValue)
            }
        }
    }

}

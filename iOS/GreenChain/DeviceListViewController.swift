//
//  DeviceListViewController.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DeviceListViewController: UITableViewController {

    var devices: [Device]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        Alamofire.request(BASE_URL + "user/devices").responseJSON { (response) in
            let json = JSON(data: response.data!)
            self.devices = []
            for (_, subJson):(String, JSON) in json["devices"] {
                self.devices?.append(Device(with: subJson))
            }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "device", for: indexPath) as! DeviceCell
        cell.device = devices?[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "push", sender: indexPath)
    }
    
}

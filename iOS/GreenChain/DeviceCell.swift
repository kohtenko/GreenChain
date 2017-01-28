//
//  DeviceCell.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!

    var device: Device! {
        didSet {
            nameLabel.text = device.name
            iconView.image = device.type.icon
        }
    }

}

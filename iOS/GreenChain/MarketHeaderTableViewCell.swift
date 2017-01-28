//
//  MarketHeaderTableViewCell.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit

class MarketHeaderTableViewCell: MarketBasicTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override var item: MarketItem! {
        didSet {
            nameLabel.text = item.title
            subnameLabel.text = item.subtitle
            priceLabel.text = "\(item.price!)"
        }
    }
    
}

//
//  MarketFooterTableViewCell.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit

class MarketFooterTableViewCell: MarketBasicTableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!

    override var item: MarketItem! {
        didSet {
            descriptionLabel.text = item.description
        }
    }
    
}

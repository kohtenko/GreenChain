//
//  MarketCollectionCell.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit

class MarketCollectionCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var marketItem: MarketItem? {
        didSet {
            image.image = marketItem?.image
            nameLabel.text = marketItem?.title
            subnameLabel.text = marketItem?.subtitle
            priceLabel.text = "\(marketItem?.price ?? 1)"
        }
    }
}

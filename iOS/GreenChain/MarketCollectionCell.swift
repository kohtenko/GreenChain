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

    var marketItem: MarketItem? {
        didSet {
            image.image = marketItem?.image
        }
    }
}

//
//  MarketImagesTableViewCell.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit

class MarketImagesTableViewCell: MarketBasicTableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    override var item: MarketItem! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath)
        if let imageView = cell.contentView.subviews.first as? UIImageView {
            if indexPath.row == 0 {
                imageView.image = item.image
            } else {
                imageView.image = UIImage(named: "map")
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}

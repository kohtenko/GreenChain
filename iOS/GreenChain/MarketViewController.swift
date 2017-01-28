//
//  MarketViewController.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    private var images: [ Int: [UIImage]]!
    private let titles = ["Featured", "Food", "Services", "Devices"]

    override func viewDidLoad() {
        super.viewDidLoad()
        images = [
            0: [
                UIImage(named: "f1")!,
                UIImage(named: "f2")!
            ],
            1: [
                UIImage(named: "1")!,
                UIImage(named: "2")!,
                UIImage(named: "3")!
            ],
            2: [
                UIImage(named: "4")!,
                UIImage(named: "5")!,
                UIImage(named: "6")!
            ],
            3: [
                UIImage(named: "7")!,
                UIImage(named: "8")!,
                UIImage(named: "9")!
            ]
        ]
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MarketHeaderView
        header.label.text = titles[indexPath.section]
        return header
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images[section]!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "market", for: indexPath) as! MarketCollectionCell

        cell.image.image = images[indexPath.section]?[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return images[indexPath.section]![indexPath.row].size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 3, 0, 3)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "push", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath,
        let controller = segue.destination as? MarketDetailsViewController else {
            return
        }
controller.
    }

}

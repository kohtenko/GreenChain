//
//  MarketViewController.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    private var items: [String: [MarketItem]]?
    private let titles = ["Featured", "Food", "Services", "Devices"]

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(BASE_URL + "green-market/goods").responseJSON { (response) in
        //let closure: (DataResponse<Any>)->Void = { (response) in
            let json = JSON(data: response.data!)
            self.items = [String: [MarketItem]]()
            for (key, subJson):(String, JSON) in json {
                if self.items?[key] == nil {
                    self.items?[key] = []
                }
                for (_, itemJson):(String, JSON) in subJson {
                    self.items?[key]?.append(MarketItem(with: itemJson))
                }
            }
            self.collectionView.reloadData()
        }
        //let data = NSData(contentsOfFile: Bundle.main.path(forResource: "market", ofType: "json")!)!
        //let result = Result<Any>.success("")
        //let dataResp = DataResponse<Any>(request: nil,
        //                                 response: nil,
        //                                data: data as Data,
        //                                 result: result)
        //closure(dataResp)
    }

    private func key(forSection section: Int) -> String {
        return titles[section]
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MarketHeaderView
        header.label.text = titles[indexPath.section]
        return header
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?[key(forSection: section)]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "market", for: indexPath) as! MarketCollectionCell

        cell.marketItem = items?[key(forSection: indexPath.section)]?[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return items?[key(forSection: indexPath.section)]?[indexPath.row].image?.size ?? CGSize.zero
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
        performSegue(withIdentifier: "push", sender: items?[key(forSection: indexPath.section)]?[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = sender as? MarketItem,
            let controller = segue.destination as? MarketDetailsViewController else {
                return
        }
        controller.marketItem = item
    }
    
}

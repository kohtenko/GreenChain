//
//  MarketDetailsViewController.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit

class MarketDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var marketItem: MarketItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = marketItem.title
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return marketItem.detailsValues?.count ?? 0
        }
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MarketBasicTableViewCell!
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! MarketBasicTableViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! MarketBasicTableViewCell
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as! MarketBasicTableViewCell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! MarketDetailsTableViewCell
            cell.keyLabel.text = marketItem.key(at: indexPath.row)
            cell.valueLabel.text = marketItem.detailsValues?[cell.keyLabel.text!]
            return cell
        default:
            return UITableViewCell()
        }
        cell.item = marketItem
        return cell
    }



}

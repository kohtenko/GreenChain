//
//  MoneyViewController.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit
import MBCircularProgressBar;

class MoneyViewController: UIViewController {

    @IBOutlet weak var progressBar: MBCircularProgressBarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 1) {
            self.progressBar.value = 20
        }

    }

}

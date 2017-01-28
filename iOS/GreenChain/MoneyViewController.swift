//
//  MoneyViewController.swift
//  GreenChain
//
//  Created by Oleg Kokhtenko on 28/01/2017.
//  Copyright © 2017 DataArt. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import Alamofire
import SwiftyJSON
import Async

class MoneyViewController: UIViewController {

    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    @IBOutlet weak var valueLabel: UILabel!
    private let interval: TimeInterval = 1.5
    private var animationClosure: (() -> Void)!
    private var wasLoaded = false
    private var moneyValue = 0

    private var shouldMakeRequests = false

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.showValueString = false
        self.progressBar.value = 0
        self.progressBar.emptyLineWidth = 0
        animationClosure = {
            UIView.animate(withDuration: self.interval) {
                if self.progressBar.value == 100 {
                    self.progressBar.value = 30
                } else {
                    self.progressBar.value = 100
                }
            }
        }
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { (timer) in
            self.animationClosure()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldMakeRequests = true
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0
        rotate.toValue = 2 * M_PI
        rotate.duration = 5;
        rotate.repeatCount = MAXFLOAT
        self.progressBar.layer.add(rotate, forKey: "rotation")
        update()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shouldMakeRequests = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !wasLoaded {
            self.animationClosure()
        }
        wasLoaded = true
    }

    private func update() {
        return
        if shouldMakeRequests {
            Alamofire.request(BASE_URL + "user/devices").responseJSON { (response) in
                if let data = response.data {
                    self.moneyValue = JSON(data: data).intValue
                    self.valueLabel.text = "\(self.moneyValue)"
                }
                Async.main(after: 0.5) {
                    self.update()
                }

            }
        }
    }
    
}

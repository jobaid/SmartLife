//
//  emergency balance.swift
//  Project 101
//
//  Created by Jobaid on 20/7/19.
//  Copyright © 2019 Jobaid. All rights reserved.
//

import UIKit

class emergency_balance: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gp(_ sender: Any) {
        let number  = "*121*1*3#"
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func robi(_ sender: Any) {
        let number  = "*123*007#"
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func airtel(_ sender: Any) {
        let number  = "*141*10#"
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func teletalk(_ sender: Any) {
        let number  = "*1122#"
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.openURL(url)
        }
    }
}

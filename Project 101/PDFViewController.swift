//
//  PDFViewController.swift
//  Project 101
//
//  Created by Jobaid on 22/8/19.
//  Copyright © 2019 Jobaid. All rights reserved.
//

import UIKit
import WebKit

class PDFViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    var ID : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url: URL! = URL(string: ID)
        webView.load(URLRequest(url: url))
        
    }
    
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

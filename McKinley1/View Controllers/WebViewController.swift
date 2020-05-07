//
//  WebViewController.swift
//  McKinley1
//
//  Created by Devesh Tyagi on 07/05/20.
//  Copyright © 2020 deveshtyagi7. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var WebView: WKWebView!
    
    let Url : URL? = nil
    var token : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = UserDefaults.standard.string(forKey: "token")!
        let url = URL(string: "https://www.mckinleyrice.com/?token=\(token)")
        let request =  URLRequest(url: url!)
        WebView.load(request)
        
    }
    

   

}

//
//  BrowserViewController.swift
//  DrawerTest
//
//  Created by Spencer Curtis on 12/2/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import UIKit
import SafariServices

class BrowserViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var grabberThing: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://www.google.com") else { return }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        self.view.layer.borderColor = UIColor.black.cgColor
        self.view.layer.borderWidth = 0.2
        self.view.layer.cornerRadius = 10
        
        grabberThing.layer.cornerRadius = grabberThing.bounds.height / 2
        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

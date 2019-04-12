//
//  RestaurantViewController.swift
//  FoodOnClick
//
//  Created by abhay mone on 4/17/18.
//  Copyright © 2018 abhay mone. All rights reserved.
//

import UIKit
import WebKit


class RestaurantViewController: UIViewController {


    @IBOutlet weak var OnClick: UIButton!
    @IBOutlet weak var webView: WKWebView!
    var food_item : String = ""

    
    override func viewDidLoad()
    {
       
        super.viewDidLoad()
        

        //Google Maps URL
        let url = URL(string: "https://www.google.com/maps")
        let request = URLRequest(url: url!)
        
        //setting the frame for WebView
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.webView.frame = CGRect(x: 0, y :15, width : screenWidth, height : screenHeight)
        self.webView.load(request)
        
        
        //runs this piece of code after three seconds of view did load
        run(after: 3)
        {

            // Java Script Injection
            
            //setting the value of searchbox input textbox in the webview
            self.webView.evaluateJavaScript("document.getElementById('ml-searchboxinput').value = '\(self.food_item + " near me")'", completionHandler: {(value, error) in
                
            })
            
            
            //focusing the searchbox input textbox in the webview
            self.webView.evaluateJavaScript("document.getElementById('ml-searchboxinput').focus();", completionHandler: nil)
            
            //clicking the searchbutton programmatically
            self.webView.evaluateJavaScript("document.getElementsByClassName('ml-searchbox-right-side-button ml-search-on-blur-button')[0].click();", completionHandler: {(value, error) in

                
            })
            
        }

    
    }

    // Implementation of thread to perform search in the webview
    func run(after seconds: Int, completion: @escaping () -> Void) {
        
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline)
        {
            completion()
            
        }
        
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}

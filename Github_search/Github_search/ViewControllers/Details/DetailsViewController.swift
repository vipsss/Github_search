//
//  DetailsViewController.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {

    var model: Repository?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.isHidden = true
        self.webView.navigationDelegate = self

        self.activityIndicator.startAnimating()
        
        if let m = self.model {
            let link = URL(string: m.html_url)!
            let request = URLRequest(url: link)
            self.webView.load(request)
        }
    }
}

extension DetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
        self.webView.isHidden = false
    }
}

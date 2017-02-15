import UIKit
import WebKit

class HTMLSermonAudioController: UIViewController, WKNavigationDelegate {
   
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: "https://www.thebodyofchrist.us/audioapp/142/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(HTMLSermonAudioController.connectWithSpecifiedItem), name: urlNotification, object: nil)
    }
    
    
    let urlNotification = Notification.Name("newURLIdentifier")
 
  
    
    func connectWithSpecifiedItem(notification: NSNotification){
        let itemUrl = notification.object as! NSURL

        //webView.load(URLRequest(url: url))
        self.webView!.load(URLRequest(url: itemUrl as URL))
    }
    
    
   
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


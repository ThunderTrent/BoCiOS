import UIKit
import WebKit

class moreViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
   
    
    var websites = ["thebodyofchrist.us/more/"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        webView.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //webView.reload()
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (webView.title?.isEmpty)!{ 
         webView.reload()
        }
    }
   
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let requestURL = navigationAction.request.url!
        
        let reloadDashboardNotification = Notification.Name("reloadDashboard")
    
        
        func logoutDashboard(){
            NotificationCenter.default.post(name: reloadDashboardNotification, object: nil)
        }
        
     
        if requestURL.absoluteString.hasPrefix("https://www.thebodyofchrist.us/logout/"){
            logoutDashboard()
            tabBarController?.selectedIndex = 0
            decisionHandler(.cancel)
            //let url = URL(string: "https://www.thebodyofchrist.us/more/")!
            //webView.load(URLRequest(url: url))
        }
        else{
            decisionHandler(.allow)
        }
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

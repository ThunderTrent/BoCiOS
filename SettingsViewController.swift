import UIKit
import WebKit

class SettingsViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    var websites = ["www.thebodyofchrist.us/settings/"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    let urlNotificationRegistrationForm = Notification.Name("newURLIdentifierRegistrationForm")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.openRegistrationForm), name: urlNotificationRegistrationForm, object: nil)

     
    }
    
    func openRegistrationForm(notification: NSNotification){
        self.webView!.stopLoading()
        //self.webView!.lo
        print("test")
        let itemUrl = notification.object as! NSURL
        self.webView!.load(URLRequest(url: itemUrl as URL))
    }
    
    
  
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
        let requestURL = navigationAction.request.url!
        
        let reloadDashboardNotification = Notification.Name("reloadDashboard")
        
        let barEnableNotification = Notification.Name("barEnableNoti")
        
        func reloadDashboard(){
            NotificationCenter.default.post(name: reloadDashboardNotification, object: nil)
        }
        
        func sendEnableToBar(){
            NotificationCenter.default.post(name: barEnableNotification, object: nil)
        }
        
        if requestURL.absoluteString.hasPrefix("https://www.thebodyofchrist.us/dashboard/"){
            sendEnableToBar()
            reloadDashboard()
            tabBarController?.selectedIndex = 0
            decisionHandler(.cancel)
            
        }
        else{
        decisionHandler(.allow)
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (webView.title?.isEmpty)!{
           //webView.reload()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

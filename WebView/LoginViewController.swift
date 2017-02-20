import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: "https://www.thebodyofchrist.us/login/")!
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
 
    
  
    
    
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
          let requestURL = navigationAction.request.url!
        
        //   webView.allowsBackForwardNavigationGestures = true
        
        func sendReloadToWebViewController(){
            NotificationCenter.default.post(name: WebViewController().notificationForReload, object: nil)
        }
        
          if requestURL.absoluteString.hasPrefix("https://www.thebodyofchrist.us/dashboard/"){
        
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
         let next = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
         present(next, animated: true, completion: nil)
         
         sendReloadToWebViewController()
        
        
        // let webViewController:WebViewController = WebViewController()
        // self.present(webViewController, animated: true, completion: nil)
        
          }
        
        
        decisionHandler(.allow)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


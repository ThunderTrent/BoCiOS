import UIKit
import WebKit

class HTMLSermonAudioController: UIViewController, WKNavigationDelegate {
   
    var webView: WKWebView?
    
    var webConfig:WKWebViewConfiguration {
        get {
            
            // Create WKWebViewConfiguration instance
            var webCfg:WKWebViewConfiguration = WKWebViewConfiguration()
            
            // Setup WKUserContentController instance for injecting user script
            var userController:WKUserContentController = WKUserContentController()
            
            webCfg.allowsInlineMediaPlayback = true
            webCfg.allowsInlineMediaPlayback = true
            webCfg.ignoresViewportScaleLimits = false
            webCfg.userContentController = userController;
            
            return webCfg;
        }
    }

    
    override func viewDidLoad() {
        webView = WKWebView (frame: self.view.frame, configuration: webConfig)
        webView!.navigationDelegate = self
        view = webView!
        let url = URL(string: "https://www.thebodyofchrist.us/videoapp/?sermonID=31177")!
        webView!.load(URLRequest(url: url))
        
        webView!.allowsBackForwardNavigationGestures = true
        webView!.scrollView.pinchGestureRecognizer?.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(HTMLSermonAudioController.connectWithSpecifiedItem), name: urlNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HTMLSermonAudioController.reloadWebview), name: reloadAudioNotification, object: nil)
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        print("left")
    
        super.viewDidLoad()
        
        
        
        
    }
    
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
   
    
    func applicationDidBecomeActive(notification: NSNotification) {
        webView!.reload()
    }
    
    
    
    let urlNotification = Notification.Name("newURLIdentifier")
    let reloadAudioNotification = Notification.Name("reloadAudio")
 
  
    
    func connectWithSpecifiedItem(notification: NSNotification){
        let itemUrl = notification.object as! NSURL

        //webView.load(URLRequest(url: url))
        self.webView!.load(URLRequest(url: itemUrl as URL))
    }
    
    func reloadWebview(notification: NSNotification){
        let urlAudioHome = URL(string: "https://www.thebodyofchrist.us/videoapp/?sermonID=31177")!
        self.webView!.load(URLRequest(url: urlAudioHome as URL))
        print("Reloaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (webView!.title?.isEmpty)!{
            webView!.reload()
        }
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


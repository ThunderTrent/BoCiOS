var host = "thebodyofchrist.us"  // Domain host without http:// or www. (e.g. "google.com")
var webviewurl = "https://www.thebodyofchrist.us/dashboard/"  //Your URL including http:// and www.
var uselocalhtmlfolder = "false"  //Set to "true" to use local "local-www/index.html" file instead of URL
var openallexternalurlsinsafaribydefault = "false"  //Set to "true" to open links in Safari, which are not your domain host
var preventoverscroll = "true"  //Set to "true" to stop the WebView bounce animation (recommended for most cases)
var deletechache = "false"  //Set to "true" to delete the chache while starting the app
var okbutton = "OK"  //Text label of the "OK" buttons
var useragent = "BoC_Browser"  //Customized UserAgent for WebView URL requests (leave it empty to use the default iOS UserAgent)
var firstrunmessagetitle = "Welcome!"  //Title label of the "First run" alert box
var firstrunmessage = "Thank you for downloading this app!" //Text label of the "First run" a/Users/trentbrown/Downloads/Settings-icon.pnglert box
var offlinetitle = "Connection Error"  //Title label of the "Offline" alert box
var offlinemsg = "Please check your connection -- Possibly down for development."  //Text of the "Offline" alert box
var screen1 = "@iTrent - for updates"  //Text label 1 of the "Offline" screen
var screen2 = "WiFi and mobile data are supported."  //Text label 2 of the "Offline" screen
var buttontext = "Try again"  //Text label of the "Try again" button
var ratemyapptitle = "Rate / Share the Body of Christ App?"  //Title label of the "Rate my app" dialog box
var ratemyapptext = "Will only take a few seconds..."  //Text label of the "Rate my app" dialog
var ratemyappyes = "Rate"  //Text label of the "Yes" button on "Rate my app" dialog box
var ratemyappno = "No"  //Text label of the "No" button on "Rate my app" dialog box
var ratemyappurl = "http://itunes.apple.com"  //Your App Store URL for the "Rate my app" dialog (there is a "View in App Store" link in iTunes Connect)
var becomefacebookfriendstitle = "Stay tuned"  //Title label of the "Follow on Facebook" dialog
var becomefacebookfriendstext = "Become friends on Facebook?"  //Text label of the "Follow on Facebook" dialog
var becomefacebookfriendsyes = "Yes"  //Text label of the "Yes" button of the "Follow on Facebook" dialog
var becomefacebookfriendsno = "No"  //Text label of the "No" button of the "Follow on Facebook" dialog
var becomefacebookfriendsurl = "https://www.facebook.com/BodyofChristApp/" //URL of your Facebook fanpage
var imagedownloadedtitle = "Image saved to your photo gallery."  //Title label of the "Image saved to your photo gallery" dialog box
var imagenotfound = "Image not found."  //Title label of the "Image not found" dialog box

let statusbarbackgroundcolor = UIColor(red: CGFloat(0 / 255.0), green: CGFloat(0 / 255.0), blue: CGFloat(255 / 255.0), alpha: CGFloat(1.0))
var usemystatusbarbackgroundcolor = "false"  //Set to "true" to activate the custom status bar background color
//Use a service like "RGB Color Picker": http://www.colorpicker.com

let statusbarcolor = UIColor(red: CGFloat(225 / 255.0), green: CGFloat(0 / 255.0), blue: CGFloat(0 / 255.0), alpha: CGFloat(1.0))
var usemystatusbarcolor = "false"
//Set to "true" to activate the custom status bar text color (inofficial API, see http://stackoverflow.com/questions/23512700/how-to-set-text-color-of-status-bar-other-than-white-and-black) //Use a service like "RGB Color Picker": http://www.colorpicker.com }
/************************************************************************************************************************/



import UIKit
import AVFoundation
import UserNotifications
import WebKit

class WebViewController: UIViewController
{
    @IBOutlet var loadingSign: UIActivityIndicatorView!
    @IBOutlet var offlineImageView: UIImageView!
    @IBOutlet var lblText1: UILabel!
    @IBOutlet var lblText2: UILabel!
    @IBOutlet var btnTry: UIButton!
    @IBOutlet var statusbarView: UIView!
    var webView: WKWebView!
    
    var isFirstTimeLoad = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        isFirstTimeLoad = true
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
        }
        
        if usemystatusbarcolor.isEqual("true")
        {
            _ = self.setStatusBarColor(statusbarcolor)
        }
        
        if usemystatusbarbackgroundcolor.isEqual("true")
        {
            self.statusbarView.backgroundColor = statusbarbackgroundcolor
        }
        
        if useragent.isEqual("")
        {
            
        }
        else
        {
            let customuseragent = [
                "UserAgent" : "BOC_Browser"
            ]
            
            UserDefaults.standard.register(defaults: customuseragent)
        }
        
        UIApplication.shared.statusBarStyle = .default
    
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        addWebViewToMainView()
        
        
        let phonecheck = UIScreen.main.bounds
        let statusbar: CGFloat = 20
        
        if phonecheck.size.height == 667 - statusbar
        {
            offlineImageView.frame = CGRect(x: CGFloat(103), y: CGFloat(228), width: CGFloat(170), height: CGFloat(170))
            lblText1.frame = CGRect(x: CGFloat(40), y: CGFloat(400), width: CGFloat(295), height: CGFloat(50))
            lblText2.frame = CGRect(x: CGFloat(25), y: CGFloat(435), width: CGFloat(326), height: CGFloat(50))
            btnTry.frame = CGRect(x: CGFloat(110), y: CGFloat(520), width: CGFloat(150), height: CGFloat(20))
        }
        
        if phonecheck.size.height == 736 - statusbar
        {
            offlineImageView.frame = CGRect(x: CGFloat(123), y: CGFloat(205), width: CGFloat(170), height: CGFloat(170))
            lblText1.frame = CGRect(x: CGFloat(60), y: CGFloat(346), width: CGFloat(295), height: CGFloat(50))
            lblText2.frame = CGRect(x: CGFloat(44), y: CGFloat(374), width: CGFloat(326), height: CGFloat(50))
            btnTry.frame = CGRect(x: CGFloat(132), y: CGFloat(453), width: CGFloat(150), height: CGFloat(20))
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let url = URL(string: webviewurl)!
        host = url.host ?? ""
        
        if preventoverscroll.isEqual("true")
        {
            self.webView.scrollView.bounces = false
        }
        
        
        
        if deletechache.isEqual("true")
        {
            URLCache.shared.removeAllCachedResponses()
        }
        
        view.bringSubview(toFront: loadingSign)

        webView.scrollView.bouncesZoom = false
        webView.autoresizingMask = ([.flexibleHeight, .flexibleWidth])
        
        offlineImageView.isHidden = true
        loadingSign.stopAnimating()
        loadingSign.isHidden = true
        btnTry.setTitle(buttontext, for: .normal)
        btnTry.setTitle(buttontext, for: .selected)
        lblText1.text = screen1
        lblText2.text = screen2
        lblText1.isHidden = true
        lblText2.isHidden = true
        btnTry.isHidden = true
        
        var onlinecheck = url.absoluteString
        
        if uselocalhtmlfolder.isEqual("true")
        {
            let urllocal = URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!)
            webView.load(URLRequest(url: urllocal))
        }
        else
        {
            if onlinecheck.characters.count == 0
            {
                offlineImageView.isHidden = false
                webView.isHidden = true
                lblText1.isHidden = false
                lblText2.isHidden = false
                btnTry.isHidden = false
                loadingSign.isHidden = true
            }
            else
            {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
        
        self.perform(#selector(self.checkForAlertDisplay), with: nil, afterDelay: 0.5)
    }

    func addWebViewToMainView()
    {
        view.addSubview(webView)
        
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 20))
        
        view.addConstraint(NSLayoutConstraint(item: webView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem:view, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: webView, attribute: .right, relatedBy: .equal, toItem: view , attribute: .right, multiplier: 1, constant:0))
        
        view.layoutIfNeeded()
        
        
    }
    
    func checkForAlertDisplay()
    {
        let user = UserDefaults.standard
        srandom(UInt32(time(nil)))
        let randnum = arc4random() % 10
        
        if !user.bool(forKey: "ratemyapp")
        {
            if randnum == 1
            {
                user.set("1", forKey: "ratemyapp")
                user.synchronize()
                
                let alertController = UIAlertController(title: ratemyapptitle, message: ratemyapptext, preferredStyle: UIAlertControllerStyle.alert)
                
                let yesAction = UIAlertAction(title: ratemyappyes, style: UIAlertActionStyle.default, handler: {
                    alert -> Void in
                    
                    let prefeedback = ratemyappurl
                    let feedback = URL(string: prefeedback)!
                    UIApplication.shared.openURL(feedback)
                    
                })
                
                let noAction = UIAlertAction(title: ratemyappno, style: UIAlertActionStyle.cancel, handler: {
                    (action : UIAlertAction!) -> Void in
                    
                })
                
                alertController.addAction(yesAction)
                alertController.addAction(noAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        if !user.bool(forKey: "becomefbfriends")
        {
            if randnum == 2
            {
                user.set("1", forKey: "becomefbfriends")
                user.synchronize()
                
                let alertController = UIAlertController(title: becomefacebookfriendstitle, message: becomefacebookfriendstext, preferredStyle: UIAlertControllerStyle.alert)
                
                let yesAction = UIAlertAction(title: becomefacebookfriendsyes, style: UIAlertActionStyle.default, handler: {
                    alert -> Void in
                    
                    let prefeedback = becomefacebookfriendsurl
                    let feedback = URL(string: prefeedback)!
                    UIApplication.shared.openURL(feedback)
                    
                })
                
                let noAction = UIAlertAction(title: becomefacebookfriendsno, style: UIAlertActionStyle.cancel, handler: {
                    (action : UIAlertAction!) -> Void in
                    
                })
                
                alertController.addAction(yesAction)
                alertController.addAction(noAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        if !user.bool(forKey: "firstrun")
        {
            user.set("1", forKey: "firstrun")
            user.synchronize()
            
            let alertController = UIAlertController(title: firstrunmessagetitle, message: firstrunmessage, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: okbutton, style: UIAlertActionStyle.cancel, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setStatusBarColor(_ color: UIColor) -> Bool
    {
        let statusBar = UIApplication.shared.statusBarView
        let setForegroundColor_sel = NSSelectorFromString("setForegroundColor:")
        
        if statusBar!.responds(to: setForegroundColor_sel)
        {
            _ = statusBar?.perform(setForegroundColor_sel, with: color)
            return true
        }
        else
        {
            return false
        }
    }
    
    func downloadImageAndSave(toGallary imageURLString: String)
    {
        DispatchQueue.global().async {
            
            do
            {
                let data = try Data(contentsOf: URL(string: imageURLString)!)
                
                DispatchQueue.global().async {
                    DispatchQueue.global().async {
                        UIImageWriteToSavedPhotosAlbum(UIImage(data: data)!, nil, nil, nil)
                    }
                    
                    self.loadingSign.stopAnimating()
                    self.loadingSign.isHidden = true
                    
                    let alertController = UIAlertController(title: imagedownloadedtitle, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: okbutton, style: UIAlertActionStyle.cancel, handler: {
                        (action : UIAlertAction!) -> Void in
                        
                    })
                    
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
            catch
            {
                DispatchQueue.global().async {
                    self.loadingSign.stopAnimating()
                    self.loadingSign.isHidden = true
                    
                    let alertController = UIAlertController(title: imagenotfound, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: okbutton, style: UIAlertActionStyle.cancel, handler: {
                        (action : UIAlertAction!) -> Void in
                        
                    })
                    
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func clickToBtnTry(_ sender: Any)
    {
        let url = URL(string: webviewurl)!
        
        offlineImageView.isHidden = true
        lblText1.isHidden = true
        lblText2.isHidden = true
        btnTry.isHidden = true
        webView.isHidden = false
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

extension WebViewController: WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        loadingSign.startAnimating()
        loadingSign.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        loadingSign.stopAnimating()
        loadingSign.isHidden = true
        isFirstTimeLoad = false
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
    {
        if((error as NSError).code == NSURLErrorNotConnectedToInternet)
        {
            if(!isFirstTimeLoad)
            {
                let alertController = UIAlertController(title: offlinetitle, message: offlinemsg, preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: okbutton, style: UIAlertActionStyle.cancel, handler: {
                    (action : UIAlertAction!) -> Void in
                    
                })
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            isFirstTimeLoad = false
            webView.isHidden = true
            loadingSign.isHidden = true
            offlineImageView.isHidden = false
            lblText1.isHidden = false
            lblText2.isHidden = false
            btnTry.isHidden = false
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        let requestURL = navigationAction.request.url!
        
        webView.allowsBackForwardNavigationGestures = true
       
        if requestURL.absoluteString.hasPrefix("savethisimage://?url=")
        {
            let imageURL = requestURL.absoluteString.substring(from: requestURL.absoluteString.index(requestURL.absoluteString.startIndex, offsetBy: "savethisimage://?url=".characters.count))
            self.downloadImageAndSave(toGallary: imageURL)
            loadingSign.stopAnimating()
            self.loadingSign.isHidden = true
            
            decisionHandler(.cancel)
            return
        }
        
        if (requestURL.host != nil) && !(host == requestURL.host!) && (navigationAction.navigationType == .linkActivated) && openallexternalurlsinsafaribydefault.isEqual("true")
        {
            UIApplication.shared.openURL(requestURL)
            loadingSign.stopAnimating()
            self.loadingSign.isHidden = true
            
            decisionHandler(.cancel)
            return
        }
        
        func sendData(url: URL){
            NotificationCenter.default.post(name: HTMLSermonAudioController().urlNotification, object: requestURL)
        }
        
        if requestURL.absoluteString.hasPrefix("https://www.thebodyofchrist.us/audioapp/"){
            tabBarController?.selectedIndex = 3
            sendData(url: requestURL)
            decisionHandler(.cancel)
            return
        }
    
        
        if ((requestURL.host != nil) && requestURL.host! == "push.send.cancel")
        {
            UIApplication.shared.cancelAllLocalNotifications()
            
            decisionHandler(.cancel)
            return
        }
        
        if ((requestURL.host != nil) && requestURL.host! == "push.send")
        {
            let prerequest = requestURL
            let finished = prerequest.absoluteString
            var requested = finished.components(separatedBy: "=")
            let seconds = requested[1]
            var logindetails = finished.components(separatedBy: "msg!")
            let logindetected = logindetails[1]
            var logindetailsmore = logindetected.components(separatedBy: "&!#")
            let msg0 = logindetailsmore[0]
            let button0 = logindetailsmore[1]
            let msg = msg0.replacingOccurrences(of: "%20", with: " ")
            let button = button0.replacingOccurrences(of: "%20", with: " ")
            let sendafterseconds: Double = Double(seconds)!
            
            if #available(iOS 10.0, *)
            {
                let action = UNNotificationAction(identifier: "buttonAction", title: button, options: [])
                let category = UNNotificationCategory(identifier: "localNotificationTest", actions: [action], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([category])
                
                let notificationContent = UNMutableNotificationContent()
                notificationContent.body = msg
                notificationContent.sound = UNNotificationSound.default()
                
                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: sendafterseconds, repeats: false)
                
                let localNotificationRequest = UNNotificationRequest(identifier: "localNotificationTest", content: notificationContent, trigger: notificationTrigger)
                
                UNUserNotificationCenter.current().add(localNotificationRequest) {(error) in
                    if let error = error {
                        print("We had an error: \(error)")
                    }
                }
            }
            else
            {
                let pushmsg1 = UILocalNotification()
                pushmsg1.fireDate = Date().addingTimeInterval(sendafterseconds)
                pushmsg1.timeZone = NSTimeZone.default
                pushmsg1.alertBody = msg
                pushmsg1.soundName = UILocalNotificationDefaultSoundName
                pushmsg1.alertAction = button
                UIApplication.shared.scheduleLocalNotification(pushmsg1)
            }
            
            decisionHandler(.cancel)
            return
        }
        
        if uselocalhtmlfolder == "true" {
            if (requestURL.scheme! == "http") || (requestURL.scheme! == "https") || (requestURL.scheme! == "mailto") && (navigationAction.navigationType == .linkActivated)
            {
                UIApplication.shared.openURL(requestURL)
                
                decisionHandler(.cancel)
                return
            }
            else
            {
                decisionHandler(.allow)
                return
            }
        }
        else {
            
            
            /* Open specific URL "http://m.facebook.com" links in Safari START */
           /* if ((requestURL.host != nil) && requestURL.host! == "m.facebook.com")
            {
                loadingSign.stopAnimating()
                self.loadingSign.isHidden = true
                UIApplication.shared.openURL(requestURL)
                decisionHandler(.cancel)
                return
            }*/
            /* Open specific URL "http://m.facebook.com" links in Safari END */
            
            
            
            decisionHandler(.allow)
        }
    }
}

extension UIApplication
{
    var statusBarView: UIView?
    {
        return value(forKey: "statusBar") as? UIView
    }
}



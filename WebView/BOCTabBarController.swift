//
//  BOCTabBarController.swift
//  WebView
//
//  Created by Trent Brown on 2/15/17.
//  Copyright © 2017 Kartum Infotech. All rights reserved.
//

import UIKit

class BOCTabBarController: UITabBarController {

    
    
    
    @IBOutlet weak var bottomBar: UITabBar!
    

  
   let reloadAudioNotification = Notification.Name("reloadAudio")
    
   let barEnableNotification = Notification.Name("barEnableNoti")
   let barDisableNotification = Notification.Name("barDisableNoti")

    func enableBarTabs(){
         bottomBar.items![0].isEnabled = true
         bottomBar.items![1].isEnabled = true
         bottomBar.items![2].isEnabled = true
         bottomBar.items![3].isEnabled = true
        
      //  NotificationCenter.default.post(name: HTMLSermonAudioController().reloadAudioNotification, object: nil)
        
    }
    func disableBarTabs(){
        bottomBar.items![0].isEnabled = true
        bottomBar.items![1].isEnabled = false
        bottomBar.items![2].isEnabled = false
        bottomBar.items![3].isEnabled = false
        
        //  NotificationCenter.default.post(name: HTMLSermonAudioController().reloadAudioNotification, object: nil)
        
    }
    
    override func viewDidLoad() {
       
        
    
      
        super.viewDidLoad()
        
        
        //bottomBar.items![1].isEnabled = true
        bottomBar.barStyle = UIBarStyle.black
        bottomBar.tintColor = UIColor.white
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(BOCTabBarController.enableBarTabs), name: barEnableNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BOCTabBarController.disableBarTabs), name: barDisableNotification, object: nil)
        
        
        //nableBarTabs()
        
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



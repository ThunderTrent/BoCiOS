import UIKit

class MoreItemsTableViewController: UITableViewController {
    
    var menuItems = MoreMenuItems()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = menuItems.names[row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        
        let currentLink = menuItems.links[row]
    
        if currentLink == (String:"deleteCache") {
        URLCache.shared.removeAllCachedResponses()
        print("Deleted Cache")
        }
        if currentLink == (String:"https://www.thebodyofchrist.us/about/") {
            let webviewurl = "https://www.thebodyofchrist.us/about/"
            let newURL = URL(string: webviewurl)!
            //UIApplication.shared.openURL(newURL)
           // print("Open About")
        }
        if currentLink == (String:"MenofGod") {
            let webviewurl = "https://www.thebodyofchrist.us/timelineLarge/"
            let newURL = URL(string: webviewurl)!
              UIApplication.shared.openURL(newURL)
             print("Open Timeline Large")
        }
        if currentLink == (String:"Privacy") {
            let webviewurl = "https://www.thebodyofchrist.us/privacy/"
            let newURL = URL(string: webviewurl)!
            UIApplication.shared.openURL(newURL)
            print("Open Privacy")
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

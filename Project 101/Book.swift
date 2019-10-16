import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import NVActivityIndicatorView
import UIColor_Hex_Swift

class Book : UIViewController ,NVActivityIndicatorViewable{
    
   
    @IBOutlet weak var tblview: UITableView!
    @objc var refreshControl: UIRefreshControl!
    
    
    
    @objc var arrRes = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if connectedToNetwork() == true {
           
            
            
            getdata()
        }
        else {
            showEventsAcessDeniedAlert()
        }
        
        setupPullToRefresh()
        
    }
    func Loadingbar(){
        let size = CGSize(width: 80, height: 80)
        
        startAnimating(size, message: "Loading", type:  .orbit, color: UIColor("#ff2052") )
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10)  {
            self.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc(tableView:heightForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getdata(){
        Alamofire.request("https://test-eba99.firebaseio.com/.json").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["Book"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblview.reloadData()
                }
            }
        }
    }
    
    
    
    @objc func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jcell")!
        var dict = arrRes[(indexPath as NSIndexPath).row]
        let texts = cell.viewWithTag(9) as! UILabel
       // let image = cell.viewWithTag(10) as! UIImageView
        
        texts.text = dict["bookcat"] as? String
      //  let url = URL(string : (dict["i"] as? String)!)!
        
        
      //  image.af_setImage(withURL: url, placeholderImage: nil)
        
        
        return cell
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "id" {
            
           if let indexPath = self.tblview.indexPathForSelectedRow {
             let controller = segue.destination as! booklist
              let value = arrRes[indexPath.row]//
            controller.ID = value["Cat"] as? String
                //controller.Full = value[""] as! String
                //controller.images = value["image"] as! String
       }
            
            
       }
        
    }
    
    
    @objc func setupPullToRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        self.refreshControl.backgroundColor = UIColor.black
        self.refreshControl.tintColor = UIColor.white
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.tblview.addSubview(refreshControl)
    }
    @objc func refresh(sender: AnyObject) {
        // Pull to Refresh
        //stations.removeAll(keepingCapacity: false)
        
        getdata()
        
        // Wait 2 seconds then refresh screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshControl.endRefreshing()
            self.view.setNeedsDisplay()
        }
    }
    func showEventsAcessDeniedAlert() {
        let alertController = UIAlertController(title: "No Internet Connection",
                                                message: "Please Connect Your Mobile Data or WIFI Connection",
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            
            // THIS IS WHERE THE MAGIC HAPPENS!!!!
            if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(appSettings as URL)
            }
        }
        alertController.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    //admob
  
    
}





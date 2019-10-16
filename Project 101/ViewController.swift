//
//  ViewController.swift
//  Project 101
//
//  Created by Jobaid on 19/7/19.
//  Copyright © 2019 Jobaid. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import MessageUI
import NVActivityIndicatorView
import UIColor_Hex_Swift
class ViewController: UIViewController,NVActivityIndicatorViewable {
 
    

    @IBOutlet var buttonshow: RoundButton!
    
    var ref: DatabaseReference!
    
    let locationManager = CLLocationManager()
    let locationManagers = CLLocationManager()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Loadingbar()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //sms
        locationManagers.delegate = self
        locationManagers.desiredAccuracy = kCLLocationAccuracyHundredMeters
        ///
          ref = Database.database().reference().child("Police");
      //
        
        //
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    }
    func buttonhide() {
         Timer.scheduledTimer(timeInterval: TimeInterval(10), target: self, selector: #selector(ViewController.hide), userInfo: nil, repeats: false)
    }
    @objc func hide(){
        buttonshow.isHidden = false
    }
    func Loadingbar(){
        let size = CGSize(width: 80, height: 80)
        
        startAnimating(size, message: "Loading", type:  .orbit, color: UIColor("#ff2052") )
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4)  {
            self.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func getCurrentLocationTapped(_ sender: Any) {
        retriveCurrentLocation()
        let alert = UIAlertController(title: "Your Location Saved in our database", message: "We Are coming on your location ,Stay there and Keep safe", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        buttonshow.isHidden = true
        buttonhide()
    }
    @IBAction func Call(_ sender: Any) {
        if let url = URL(string: "tel://\(999)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()
        
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            return
        }
        
        // if haven't show location permission dialog before, show it to user
        if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
            
            // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
            //locationManager.requestAlwaysAuthorization()
            return
        }
        
     
        
        // request location data for one-off usage
        locationManager.requestLocation()
        
        // keep requesting location data until stopUpdatingLocation() is called
        // locationManager.startUpdatingLocation()
    }
    
    
    //sms
 
    ///
}

extension ViewController : CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    // called when the authorization status is changed for the core location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let key = ref.childByAutoId().key
            let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
            
            let policedata = [ "id":key,
                        "Alert": "Please Help me!!" as String,
                          
                          "UUID":  "\( UUID().uuidString)" as String,
                          
                          "locationgetiing" : " http://maps.google.com/maps?q= \(location.coordinate.latitude),\(location.coordinate.longitude)" as String,
                          "date": "\(timestamp) " as String
               
                
                
                          
                        
                
            ]
          
            ref.child((key ?? nil)!).setValue(policedata)
            
        }
 
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
     
    }
    
  
    
    
    
   
    
    
    /////////////
    



}



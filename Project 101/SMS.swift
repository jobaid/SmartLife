//
//  SMS.swift
//  Project 101
//
//  Created by Jobaid on 24/8/19.
//  Copyright © 2019 Jobaid. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI
class SMS: UIViewController {

    
    let locationManager = CLLocationManager()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //sms
        let alert = UIAlertController(title: "Alert!", message: "Click The SMS button .Share your location via SMS", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    
    }
 
    
    @IBAction func Click(_ sender: Any) {
        retriveCurrentLocation()
      

    }
    
    func displayMessageInterface() {
      
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
    

}
extension SMS : CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
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
           
      
                
       
            //
            
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.recipients = ["+8801689456548"]
            composeVC.body = "http://maps.google.com/maps?q= \(location.coordinate.latitude),\(location.coordinate.longitude)"
            
            // Present the view controller modally.
            if MFMessageComposeViewController.canSendText() {
                self.present(composeVC, animated: true, completion: nil)
            }
            
        }
        
    }
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        
}
}

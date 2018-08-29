//
//  DriverVC.swift
//  Uber App For Driver
//
//  Created by Artem Antuh on 8/27/18.
//  Copyright © 2018 Artem Antuh. All rights reserved.
//

import UIKit
import MapKit

class DriverVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UberController {
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    private var locationManager = CLLocationManagerDelegate
    private var userLocation: CLLocationCoordinate2D?
    //    private var riderLocation: CLLocationCoordinate2D?
    
    private var acceptedUber = false
    private var driverCanceledUber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLocationManager()
        
        UberHandler.Instance.delegate = self
        UberHandler.Instance.observeMessagesForDriver()
    }
    
    private func initializeLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //if we have coordinates from the manager
        if let location = locationManager.location?.coordinate {
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            //setting up navigation region
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            myMap.setRegion(region, animated: true)
            myMap.removeAnnotations(myMap.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation!
            annotation.title = "Drivers Loaction"
            myMap.addAnnotation(annotation)
        }
        
    }
    func acceptUber(lat: Double, long: Double) {
//        uberRequest(title: "Uber Request", message: "You have a request for an Uber for this location Lat: \(lat), Long: \(long)", requestAlive: true)
        if !acceptedUber {
            uberRequest(title: "Uber Request",
                        message: "You have a request for an Uber for this location Lat: \(lat), Long: \(long)",
                        requestAlive: true)
        }
    }
    
    @IBAction func cancelUber(_ sender: Any) {
    }
    
    @IBAction func logOut(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        }
        else
        {
            //problem
            uberRequest(title: "Could Not LogOut", message: "Try later", requestAlive: false)
            
            //            alertTheUser(title: "Could Not LogOut", message: "Try later")
        }
    }
    
    private func uberRequest(title: String,message: String,requestAlive: Bool) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert);
        if requestAlive {
            let accept = UIAlertAction(title: "Accept", style: .default, handler: {(alertAction: UIAlertAction) in
                
                
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(accept)
            alert.addAction(cancel)
        }
        else
        {
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //    private func alertTheUser(title: String, message: String) {
    //        let alert = UIAlertController(title: title,
    //                                      message: message,
    //                                      preferredStyle: .alert);
    //
    //        let ok = UIAlertAction(title: "OK",
    //                               style: .default,
    //                               handler: nil);
    //        alert.addAction(ok)
    //        present(alert, animated: true, completion: nil)
    //    }
    
    
}

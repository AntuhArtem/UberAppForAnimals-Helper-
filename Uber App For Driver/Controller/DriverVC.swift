//
//  DriverVC.swift
//  Uber App For Driver
//
//  Created by Artem Antuh on 8/27/18.
//  Copyright © 2018 Artem Antuh. All rights reserved.
//

import UIKit
import MapKit

class DriverVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var myMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            alertTheUser(title: "Could Not LogOut", message: "Try later")
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert);
        
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: nil);
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    

}

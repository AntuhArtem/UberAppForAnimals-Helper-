//
//  UberHandler.swift
//  Uber App For Driver
//
//  Created by Artem Antuh on 8/29/18.
//  Copyright © 2018 Artem Antuh. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UberController: class {
    func acceptUber(lat: Double, long: Double)
}

class UberHandler {
    private static let _instance = UberHandler()
    
    weak var delegate: UberController?
    
    var rider = ""
    var driver = ""
    var driver_id = ""
    
    static var Instance: UberHandler {
        return _instance
    }
    
    func observeMessagesForDriver() {
        // rider requested uber
        DBProvider.Instance.requestRef.observe(DataEventType.childAdded) {(snapshot: DataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let latitude = data[Constants.LATITUDE] as? Double {
                    if let longitude = data[Constants.LONGITUDE] as? Double {
                        //inform driver about request
                        
                        self.delegate?.acceptUber(lat: latitude,
                                                  long: longitude)
                    }
                }
            }
            
        }
        
        
    }//observe messages
}
est

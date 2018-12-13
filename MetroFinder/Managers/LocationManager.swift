//
//  LocationManager.swift
//  MetroFinder
//
//  Created by sanidhya on 12/8/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double)
    func locationNotDetected()
    func locationZipCode(zipcode : String)
}

class LocationDetector: NSObject {
    let locationManager = CLLocationManager()
    
    var delegate: LocationDetectorDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func findLocation() {
        let permissionStatus = CLLocationManager.authorizationStatus()
        
        switch(permissionStatus) {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            delegate?.locationNotDetected()
        case .denied:
            delegate?.locationNotDetected()
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        }
    }
}

extension LocationDetector: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var uzc=""
       
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            
        delegate?.locationDetected(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {( placemark,Error) in
            if placemark?[0].postalCode != nil {
                
                uzc=(placemark?[0].postalCode)!
                
                self.delegate?.locationZipCode(zipcode: uzc)
            } else {
              
            }
            })
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
     
        print(error.localizedDescription)
        delegate?.locationNotDetected()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            delegate?.locationNotDetected()
        }
    }
    
}

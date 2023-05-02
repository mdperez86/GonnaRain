//
//  LocationManager.swift
//  GonnaRain
//
//  Created by Maikel David Pérez Gómez on 27-04-23.
//

import Foundation
import CoreLocation
import Combine

enum LocationError {
    case notDetermined
    case denied
    case unknown
    case didFailWithError(Error)
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private var onChanged: ((CLLocation) -> Void)?
    private var onError: ((LocationError) -> Void)?
    
    func mapStatus(status: CLAuthorizationStatus) -> String {
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    func watchLocationChange(onChanged: @escaping (CLLocation) -> Void, onError: ((LocationError) -> Void)? = nil) {
        self.onChanged = onChanged
        self.onError = onError
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, mapStatus(status: status))
        
        switch status {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            return
        case .authorizedAlways:
            manager.startUpdatingLocation()
            return
        case .restricted:
            manager.startUpdatingLocation()
            return
        case .notDetermined:
            onError?(.notDetermined)
            return
        case .denied:
            onError?(.denied)
            return
        default:
            manager.requestWhenInUseAuthorization()
            onError?(.unknown)
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print(#function, location)
        
        onChanged?(location)
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
        
        onError?(.didFailWithError(error))
    }
}

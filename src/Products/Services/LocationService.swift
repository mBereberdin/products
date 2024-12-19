//
//  LocationService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 22.11.2024.
//

import Foundation

import CoreLocation.CLLocation

/// ``ILocationService``.
public final class LocationService: NSObject, ILocationService {
    
    // MARK: - Fields
    
    /// ``ILocationManager``.
    private var _locationManager: ILocationManager
    
    // MARK: - Inits
    
    /// ``ILocationService``.
    ///
    /// - Parameter locationManager: Менеджер локации.
    public init(locationManager: ILocationManager = LocationManager()) {
        self._locationManager = locationManager
    }
    
    // MARK: - Methods
    
    public func getDistanceToUserAsync(latitude: Double, longitude: Double) async -> Int? {
        guard let userLocation = try? await _locationManager.getUserLocationAsync() else {
            return nil
        }
        let pointLocation = CLLocation(latitude: latitude, longitude: longitude)
        let distance = Int(userLocation.distance(from: pointLocation))
        
        return distance
    }
    
    public func checkLocationAuthorization() {
        self._locationManager.checkLocationAuthorization()
    }
    
    public func setOnLocationAuthorizationChange(handler: @escaping()->()) {
        self._locationManager.onAuthorised = handler
    }
}

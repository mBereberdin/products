//
//  LocationManager.swift
//  Products
//
//  Created by Mikhail Bereberdin on 22.11.2024.
//

import Foundation

import CoreLocation

/// ``ILocationManager``.
public final class LocationManager: NSObject, ILocationManager {
    
    // MARK: - Fields
    
    /// Менеджер локации.
    private let _locationManager: CLLocationManager
    
    /// Продолжительная задача.
    private var _continuation: CheckedContinuation<CLLocation, Error>?
    
    /// Локация пользователя.
    private var _userLocation: CLLocation?
    
    public var onAuthorised: (()->())?
    
    public var isAuthorised: Bool {
        didSet {
            if !self.isAuthorised {
                return
            }
            
            self.onAuthorised?()
        }
    }
    
    // MARK: - Inits
    
    /// ``ILocationManager``.
    ///
    /// - Parameter locationManager: Менеджер локации.
    public init(locationManager: CLLocationManager = CLLocationManager()) {
        self._locationManager = locationManager
        self._userLocation = nil
        self._continuation = nil
        
        self.isAuthorised = false
        
        super.init()
        
        self._locationManager.delegate = self
        self._locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: - Methods
    
    public func getUserLocationAsync() async throws -> CLLocation {
        if let userLocation = self._userLocation,
           userLocation.timestamp.advanced(by: 60) > Date.now {
            return userLocation
        }
        
        let location = try await withCheckedThrowingContinuation { continuation in
            self._continuation = continuation
            
            _locationManager.requestLocation()
        }
        
        return location
    }
    
    public func checkLocationAuthorization() {
        if _locationManager.authorizationStatus == .notDetermined {
            _locationManager.requestWhenInUseAuthorization()
            
            return
        }
        
        self.isAuthorised = _locationManager.authorizationStatus != .denied
    }
}

// MARK: - CLLocationManagerDelegate extensions
extension LocationManager: CLLocationManagerDelegate {
    
    /// Сообщает делегату, что доступны новые данные о локации.
    ///
    /// - Parameters:
    ///   - manager: Объект менеджера локации, который сгенерировал событие обновления.
    ///   - locations: Массив объектов CLLocation, содержащий данные о локации.
    ///   Этот массив всегда содержит по крайней мере один объект, представляющий текущую локацию.
    ///   Если обновления были отложены или если несколько мест прибыли до того, как они могли быть доставлены,
    ///   массив может содержать дополнительные записи. Объекты в массиве организованы в том порядке, в котором они произошли.
    ///   Таким образом, последнее обновление локации находится в конце массива.
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            self._userLocation = lastLocation
            _continuation?.resume(returning: lastLocation)
            _continuation = nil
            
            return
        }
        
        fatalError("Location manager not provided location after udpdate.")
    }
    
    /// Сообщает делегату, что менеджер локации не смог получить значение локации.
    ///
    /// - Parameters:
    ///   - manager: Объект менеджера локации, который не смог получить локацию.
    ///   - error: Объект ошибки, содержащий причину, по которой не удалось получить локацию или заголовок.
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        _continuation?.resume(throwing: error)
        _continuation = nil
    }
    
    /// Сообщает делегату, что изменился статус авторизации.
    ///
    /// - Parameter manager: Объект менеджера локации, сообщивший о событии.
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.isAuthorised = manager.authorizationStatus != .notDetermined && manager.authorizationStatus != .denied
    }
}

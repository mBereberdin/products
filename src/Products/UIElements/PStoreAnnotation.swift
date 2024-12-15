//
//  PStoreAnnotation.swift
//  Products
//
//  Created by Mikhail Bereberdin on 26.11.2024.
//

import Foundation

import MapKit.MKAnnotation

/// Аннотация магазина.
public final class PStoreAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Fields
    
    // Идентификатор магазина.
    public let id: Int
    
    /// Координата аннотации.
    public let coordinate: CLLocationCoordinate2D
    
    /// Заголовок аннотации.
    public let title: String?
    
    // MARK: - Inits
    
    /// ``PStoreAnnotation``.
    ///
    /// - Parameters:
    ///   - id: Идентификатор магазина.
    ///   - title: Координата аннотации.
    ///   - coordinate: Заголовок аннотации.
    public init(id: Int, title: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.coordinate = coordinate
        self.title = title
    }
}

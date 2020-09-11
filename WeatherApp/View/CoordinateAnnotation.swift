//
//  CoordinateAnnotation.swift
//  WeatherApp
//
//  Created by Oleg Gavrilich on 11.08.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit
import MapKit

class CoordinateAnnotation: NSObject,  MKAnnotation {
    
    // MARK: - Parameters
    var coordinate: CLLocationCoordinate2D
    
    // MARK: - Life cycle
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}


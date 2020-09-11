//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Oleg Gavrilich on 13.08.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    private struct Constants {
        static let annotationReuseIdentifier: String = "CoordinateAnnotationResueID"
        static let mapScale: Double = 100000
        static let weatherDetailsSegue: String = "weatherDetailsSegue"
    }
    
    // MARK: - Parameters
    
    private let locationManager = CLLocationManager()
    private var coordinates = CLLocationCoordinate2D()
    private var annotation: CoordinateAnnotation?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.weatherDetailsSegue {
            if let detailController = segue.destination as? DetailViewController {
                detailController.coordinates = coordinates
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mapView)
        
        coordinates = mapView.convert(location, toCoordinateFrom: mapView)
        centerMap(latitude: coordinates.latitude, longitude: coordinates.longitude)
        addAnnotation(to: coordinates)
        
        performSegue(withIdentifier: Constants.weatherDetailsSegue, sender: nil)
    }
    
    func centerMap(latitude : Double, longitude: Double) {
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinateRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: Constants.mapScale, longitudinalMeters: Constants.mapScale)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotation(to coordinates: CLLocationCoordinate2D) {
        if let tapAnnotation = annotation {
            mapView.removeAnnotation(tapAnnotation)
        }
        
        let newAnnotation = CoordinateAnnotation(coordinate: coordinates)
        annotation = newAnnotation
        mapView.addAnnotation(newAnnotation)
    }
    
}

// MARK: - MKMapViewDelegate

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CoordinateAnnotation else { return nil }
        
        let identifier = Constants.annotationReuseIdentifier
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

}

// MARK: - CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentCoordinate = locations.first?.coordinate else { return }
        
        locationManager.stopUpdatingLocation()
        coordinates = CLLocationCoordinate2D(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
        addAnnotation(to: coordinates)
        centerMap(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}

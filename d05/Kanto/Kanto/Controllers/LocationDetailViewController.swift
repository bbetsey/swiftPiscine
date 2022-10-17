//
//  LocationDetailViewController.swift
//  Kanto
//
//  Created by Антон Тропин on 07.08.2022.
//

import UIKit
import MapKit
import CoreLocation

class LocationDetailViewController: UIViewController {

	@IBOutlet var mapView: MKMapView!
	
	var pin: Pin!
	let locationManager = CLLocationManager()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		locationManager.delegate = self
		mapView.delegate = self

		self.title = pin.title
		
		addPin()
		configureStartLocation()
    }

}


// MARK: - MKMapViewDelegate

extension LocationDetailViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard !(annotation is MKUserLocation) else { return nil }
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom") as? MKPinAnnotationView

		if annotationView == nil {
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "custom")
		} else {
			annotationView?.annotation = annotation
		}
		
		guard let pin = annotationView else { return nil }
		let colors: [UIColor] = [.red, .blue, .cyan, .green, .yellow, .black, .orange, .purple]
		pin.pinTintColor = colors.randomElement()!
		pin.canShowCallout = true
		pin.animatesDrop = true
		return pin
	}
	
}


// MARK: - CLLocationManagerDelegate

extension LocationDetailViewController: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		self.locationManager.stopUpdatingLocation()
		mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
	}
	
}


// MARK: - Class Methods

extension LocationDetailViewController {
	
	private func configureStartLocation() {
		guard let startLocation = pin else { return }
		mapView.setRegion(
			MKCoordinateRegion(
				center: startLocation.coordinates,
				span: MKCoordinateSpan(
					latitudeDelta: 0.1,
					longitudeDelta: 0.1)
			),
			animated: true
		)
	}
	
	private func addPin() {
		let annotation = MKPointAnnotation()
		annotation.coordinate = pin.coordinates
		annotation.title = pin.title
		annotation.subtitle = pin.subtitle
		mapView.addAnnotation(annotation)
	}

}

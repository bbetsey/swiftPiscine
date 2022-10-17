//
//  MapViewController.swift
//  Kanto
//
//  Created by Антон Тропин on 05.08.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

class MapViewController: UIViewController {
	
	
	// MARK: - Outlets
	
	@IBOutlet var mapView: MKMapView!
	@IBOutlet var mapTypeSC: UISegmentedControl!
	
	
	// MARK: - Variables
	
	var pins: [Pin] = []
	var startPin: Pin?
	let locationManager = CLLocationManager()
	enum MapType: Int { case Standart, Hybrid, Satellite }

	
	// MARK: - Overrides
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		mapView.delegate = self
		mapView.showsUserLocation = true
		
		addPins()
		createLocationButton()
		configureStartLocation()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
	}
	
	
	// MARK: - Actions
	
	@IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
			case MapType.Standart.rawValue:
				mapView.mapType = .standard
			case MapType.Hybrid.rawValue:
				mapView.mapType = .hybrid
			default:
				mapView.mapType = .satellite
		}
	}
	
}


// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
	
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

extension MapViewController: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		self.locationManager.stopUpdatingLocation()
		mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
	}
	
}


// MARK: - Class Methods

extension MapViewController {
	
	@objc private func getCurrentLocation() {
		self.locationManager.startUpdatingLocation()
	}
	
	private func setupLocationManager() {
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
	}
	
	private func createLocationButton() {
		let button = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
		button.cornerRadius = 25
		button.label = .none
		button.icon = .arrowFilled
		button.center = CGPoint(x: view.frame.size.width - 41, y: view.center.y)
		button.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
		view.addSubview(button)
	}
	
	private func configureStartLocation() {
		guard let startLocation = startPin else { return }
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
	
	private func addPins() {
		for pin in pins {
			let annotation = MKPointAnnotation()
			annotation.coordinate = pin.coordinates
			annotation.title = pin.title
			annotation.subtitle = pin.subtitle
			mapView.addAnnotation(annotation)
		}
	}
	
}

//
//  MainViewController.swift
//  Kanto
//
//  Created by Антон Тропин on 05.08.2022.
//

import UIKit

class MainViewController: UITabBarController {
	
	private let pins = Pin.getPins()

    override func viewDidLoad() {
        super.viewDidLoad()
		guard let viewControllers = self.viewControllers else { return }
		
		viewControllers.forEach { viewController in
			if let mapView = viewController as? MapViewController {
				mapView.pins = pins
				mapView.startPin = pins.first
			} else if let navigationVC = viewController as? UINavigationController {
				guard let placesVC = navigationVC.viewControllers[0] as? PlacesTableViewController else { return }
				placesVC.pins = pins
			}
		}
    }
}

//
//  PinModel.swift
//  Kanto
//
//  Created by Антон Тропин on 07.08.2022.
//

import Foundation
import CoreLocation
import UIKit


struct Pin {
	let title: String
	let subtitle: String
	let coordinates: CLLocationCoordinate2D
	
	static func getPins() -> [Pin] {
		[
			Pin(
				title: "Ecole 42",
				subtitle: "The best developer school",
				coordinates: CLLocationCoordinate2D(
								latitude: 48.89689618650818,
								longitude: 2.318586830682578
								)
				),
			Pin(
				title: "Arc de Triomphe",
				subtitle: "Attraction",
				coordinates: CLLocationCoordinate2D(
								latitude: 48.87485405115341,
								longitude: 2.295047047750615
								)
				),
			Pin(
				title: "Musee Rodin",
				subtitle: "Attraction",
				coordinates: CLLocationCoordinate2D(
								latitude: 48.85655517670923,
								longitude: 2.3207190960236455
								)
				),
		]
	}
}

// 48.87485405115341, 2.295047047750615
// 48.85655517670923, 2.3207190960236455

//
//  PlacesTableViewController.swift
//  Kanto
//
//  Created by Антон Тропин on 07.08.2022.
//

import UIKit

class PlacesTableViewController: UITableViewController {
	
	var pins: [Pin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.separatorStyle = .none
		tableView.largeContentTitle = "Places"
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		pins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
		let pin = pins[indexPath.row]
		cell.configure(for: pin)
		cell.selectionStyle = .none
        return cell
    }

	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let map = segue.destination as? MapViewController {
			guard let pin = sender as? Pin else { return }
			map.startPin = pin
			map.pins = pins
		} else if let detailMap = segue.destination as? LocationDetailViewController {
			guard let indexPath = tableView.indexPathForSelectedRow else { return }
			detailMap.pin = pins[indexPath.row]
		}
    }

}

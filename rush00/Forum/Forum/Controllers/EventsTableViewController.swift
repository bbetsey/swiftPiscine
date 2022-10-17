//
//  EventsTableViewController.swift
//  Forum
//
//  Created by Антон Тропин on 17.08.2022.
//

import UIKit

class EventsTableViewController: UITableViewController {
	
	var token: TokenData!
	var user: UserInfo! {
		didSet {
			getEvents()
		}
	}
	var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.separatorStyle = .none
		tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source


	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		"Events"
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		events.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
		cell.configureCell(for: events[indexPath.row])
		return cell
	}


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let detailVC = segue.destination as? EventDetailViewController else { return }
		guard let index = tableView.indexPathForSelectedRow else { return }
		detailVC.event = events[index.row]
		detailVC.user = user
		detailVC.token = token.accessTokenString
    }

}


extension EventsTableViewController {
	private func getEvents() {
		NetworkManager.shared.fetch(dataType: [Event].self, path: "/v2/users/\(user.id!)/events", token: token.accessTokenString) { result in
			switch result {
				case .success(let events):
					self.events = events
					self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
}

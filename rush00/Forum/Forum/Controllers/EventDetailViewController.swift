//
//  EventDetailViewController.swift
//  Forum
//
//  Created by Антон Тропин on 17.08.2022.
//

import UIKit

class EventDetailViewController: UIViewController {

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var descriptionLabel: UILabel!
	@IBOutlet var followButton: UIButton!
	
	var event: Event!
	var user: UserInfo!
	var token: String!
	private var followState: Bool = false
	
	override func viewDidLoad() {
        super.viewDidLoad()

		nameLabel.text = event.nameLabel
		descriptionLabel.text = event.descriptionLabel
		
		followButton.configuration = .prussianBlueConf()
		followButton.setTitle("Follow", for: .normal)
		
    }
    
	// NOTE: доделать подписку и отписку

	@IBAction func followAction() {
		if !followState {
			NetworkManager.shared.eventRegister(dataType: String.self, token: token, event: event.id!, user: user.id!) { result in
				switch result {
					case .success(let value):
						print(value)
					case .failure(let error):
						print(error.localizedDescription)
				}
			}
		}
		
	}
}

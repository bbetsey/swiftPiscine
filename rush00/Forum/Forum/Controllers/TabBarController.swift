//
//  TabBarController.swift
//  Forum
//
//  Created by Artem Potekhin on 17.08.2022.
//

import UIKit

class TabBarController: UITabBarController {
	
	var code: String!
	var token: TokenData?
	var user: UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
		getToken()
    }
	
	private func getToken() {
		NetworkManager.shared.fetchAccessToken(for: code) { result in
			switch result {
				case .success(let tokenData):
					self.token = tokenData
					self.getUser()
				case .failure(let error):
					print(error)
			}
		}
	}
	
	private func getUser() {
		guard let token = self.token else { return }
		NetworkManager.shared.fetch(dataType: UserInfo.self, path: "/v2/me", token: token.accessTokenString) { result in
			switch result {
				case .success(let userInfo):
					self.user = userInfo
					if let profileVC = self.viewControllers![0] as? FirstViewController {
						profileVC.token = self.token
						profileVC.user = self.user
					}
					if let eventsVC = self.viewControllers![1].children[0] as? EventsTableViewController {
						eventsVC.token = self.token
						eventsVC.user = self.user
					}
				case .failure(let error):
					print(error)
			}
		}
	}

}

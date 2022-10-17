//
//  WelcomeViewController.swift
//  Forum
//
//  Created by Антон Тропин on 17.08.2022.
//

import UIKit
import AuthenticationServices

class WelcomeViewController: UIViewController {

	@IBOutlet var logInButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		configurateButton()
    }
    
	@IBAction func logInAction() {
		NetworkManager.shared.postRequestToken(for: self) { result in
			switch result {
				case .success(let code):
					self.performSegue(withIdentifier: "account", sender: code)
				case .failure(let error):
					print(error)
			}
		}
	}
	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let tabBarVC = segue.destination as? TabBarController else { return }
		guard let code = sender as? String else { return }
		tabBarVC.code = code
    }
	

}


// MARK: -

extension WelcomeViewController: ASWebAuthenticationPresentationContextProviding {
	func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
		ASPresentationAnchor()
	}
}


// MARK: - Class Methods

extension WelcomeViewController {
	
	private func configurateButton() {
		logInButton.configuration = .prussianBlueConf()
		logInButton.setTitle("Log In", for: .normal)
	}
	
}

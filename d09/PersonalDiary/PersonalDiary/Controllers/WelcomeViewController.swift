//
//  WelcomeViewController.swift
//  PersonalDiary
//
//  Created by Антон Тропин on 22.08.2022.
//

import UIKit
import LocalAuthentication

class WelcomeViewController: UIViewController {

	@IBOutlet var authButton: UIButton!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var subTitleLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        setButtonStyle()
    }
    
	@IBAction func authButtonTapped() {
		titleLabel.isHidden = true
		subTitleLabel.isHidden = true
		authButton.isHidden = true
		
		let context = LAContext()
		var error: NSError? = nil
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Please, authorize with Touch ID".localized()
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
								   localizedReason: reason) { [weak self] success, error in
				DispatchQueue.main.async {
					guard success, error == nil else {
						self?.showAlert(with: "Failed".localized(), and: "Please, enter your password".localized())
						return
					}
					self?.performSegue(withIdentifier: "diary", sender: nil)
				}
				
			}
		} else {
			showAlert(with: "Password".localized(), and: "Please, enter your password".localized())
		}
	}

}


// MARK: - Class Methods

extension WelcomeViewController {
	private func setButtonStyle() {
		authButton.configuration = .custom(with: .white)
		authButton.setTitle("Authorization".localized(), for: .normal)
		authButton.setTitleColor(.prussianBlue, for: .normal)
		authButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
		authButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
		authButton.layer.shadowOpacity = 1.0
		authButton.layer.shadowRadius = 4
		authButton.layer.masksToBounds = false
	}
	
	private func showAlert(with title: String, and message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let saveAction = UIAlertAction(title: "Enter".localized(), style: .default) { _ in
			guard let task = alert.textFields?.first?.text, !task.isEmpty, task == "4444" else {
				self.showErrorAlert(with: "Error".localized(), and: "Wrong password".localized())
				return
			}
			self.performSegue(withIdentifier: "diary", sender: nil)
		}
		alert.addAction(saveAction)
		alert.addTextField { textField in
			textField.placeholder = "Password".localized()
		}
		present(alert, animated: true, completion: nil)
	}
	
	private func showErrorAlert(with title: String, and message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let tryAgainAction = UIAlertAction(title: "Try Again".localized(), style: .default) { _ in
			self.showAlert(with: "Password".localized(),
						   and: "Please, enter your password".localized())
		}
		alert.addAction(tryAgainAction)
		present(alert, animated: true)
	}
}

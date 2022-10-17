//
//  FirstViewController.swift
//  Forum
//
//  Created by Artem Potekhin on 16.08.2022.
//

import Foundation
import UIKit
import AuthenticationServices

class FirstViewController: UIViewController {
    
	var token: TokenData!
	var user: UserInfo! {
		didSet {
			sleep(1)
			updateView()
		}
	}
	
	@IBOutlet var paletteView: UIView!
	@IBOutlet var avatarImageView: UIImageView!
	@IBOutlet var loginLabel: UILabel!
	@IBOutlet var fullNameLabel: UILabel!
	@IBOutlet var firstCursusLabel: UILabel!
	@IBOutlet var secondCursusLabel: UILabel!
	@IBOutlet var poolMonthAndYearLabel: UILabel!
	@IBOutlet var logOutButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		paletteView.backgroundColor = .prussianBlue
		firstCursusLabel.textColor = .honewDew
		secondCursusLabel.textColor = .honewDew
		poolMonthAndYearLabel.textColor = .imperialRed
		logOutButton.configuration = .imperialRedConf()
		logOutButton.setTitle("Log Out", for: .normal)
    }

	
	override func viewDidAppear(_ animated: Bool) {
		avatarImageView.layer.cornerRadius = avatarImageView.layer.bounds.width / 2.0
		avatarImageView.clipsToBounds = true
		avatarImageView.layer.borderColor = UIColor.white.cgColor
		avatarImageView.layer.borderWidth = 3
	}
	

}


// MARK: - Class Methods

extension FirstViewController {
	
	private func updateView() {
		guard let user = self.user else { return }
		print(user.imageURL ?? "no image url")
		guard let imageURL = user.imageURL else { return }
		
		NetworkManager.shared.fetchImage(from: imageURL) { result in
			switch result {
			case .success(let data):
				print("data: \(data)")
//				self.avatarImageView.image = UIImage(data: data)
				self.avatarImageView.image = UIImage(named: "avatar")
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
		
		DispatchQueue.main.async {
			self.loginLabel.text = user.login
			self.fullNameLabel.text = "\(user.firstName ?? "none") \(user.lastName ?? "none")"
			self.firstCursusLabel.text = "\(user.cursus?[0].cursus?.name ?? "none") : \(user.cursus?[0].level ?? 0.0)"
			self.secondCursusLabel.text = "\(user.cursus?[1].cursus?.name ?? "none") : \(user.cursus?[1].level ?? 0.0)"
			self.poolMonthAndYearLabel.text = "\(user.poolMonth ?? "none"), \(user.poolYear ?? "none")"
		}
	}
}


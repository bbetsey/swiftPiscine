//
//  ArticleViewController.swift
//  PersonalDiary
//
//  Created by Антон Тропин on 22.08.2022.
//

import UIKit
import Photos
import bbetsey2022

class ArticleViewController: UIViewController, UINavigationControllerDelegate {

	@IBOutlet var titleTF: UITextField!
	@IBOutlet var contentTV: UITextView!
	@IBOutlet var coverImage: UIImageView!
	@IBOutlet var stepOneLabel: UILabel!
	@IBOutlet var stepTwoLabel: UILabel!
	@IBOutlet var stepThreeLabel: UILabel!
	
	var article: Article?
	private let pickerController = UIImagePickerController()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		stepOneLabel.text = "Step 1. Write a title".localized()
		stepTwoLabel.text = "Step 2. Write a content".localized()
		stepThreeLabel.text = "Step 3. Choose or take photo".localized()
		titleTF.placeholder = "Title".localized()
		
		pickerController.delegate = self
		titleTF.delegate = self
		contentTV.delegate = self

		titleTF.layer.borderColor = UIColor.systemGray5.cgColor
		contentTV.layer.borderColor = UIColor.systemGray5.cgColor
		contentTV.layer.borderWidth = 1
		contentTV.layer.cornerRadius = 5
		coverImage.layer.cornerRadius = 5
        
		guard let article = article else { return }
		titleTF.text = article.title
		contentTV.text = article.content
		guard let image = article.image else { return }
		coverImage.image = UIImage(data: image)
    }
    
	@IBAction func takePhotoTapped() {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			pickerController.sourceType = .camera
			present(pickerController, animated: true, completion: nil)
		}
	}
	
	@IBAction func choosePhotoTapped() {
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
			pickerController.sourceType = .photoLibrary
			present(pickerController, animated: true, completion: nil)
		}
	}
	
}


// MARK: - UIImagePickerControllerDelegate

extension ArticleViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		dismiss(animated: true, completion: nil)
		coverImage.image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)?.fixOrientation()
	}

}



// MARK: - UITextFieldDelegate

extension ArticleViewController: UITextFieldDelegate {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}
}


// MARK: - UITextViewDelegate

extension ArticleViewController: UITextViewDelegate {
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		view.endEditing(true)
	}
}


// MARK: - Class Private Methods

extension ArticleViewController {
	private func showAlert(with title: String, and message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok".localized(), style: .default)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
}

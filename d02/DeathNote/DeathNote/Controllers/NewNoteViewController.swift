//
//  NewNoteViewController.swift
//  DeathNote
//
//  Created by Антон Тропин on 27.07.2022.
//

import UIKit

class NewNoteViewController: UIViewController, UITextViewDelegate {

	@IBOutlet var descriptionTextView: UITextView!
	@IBOutlet var nameLabel: UITextField!
	@IBOutlet var surnameLabel: UITextField!
	@IBOutlet var datePicker: UIDatePicker!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		descriptionTextView.delegate = self
		nameLabel.delegate = self
		surnameLabel.delegate = self
		
		descriptionTextView.textColor = .systemGray4
		descriptionTextView.text = "Type description here..."
		descriptionTextView.layer.borderColor = UIColor.systemGray5.cgColor
		descriptionTextView.layer.borderWidth = 1.0;
		descriptionTextView.layer.cornerRadius = 5.0;
		
		datePicker.minimumDate = Date()
    }
    
	func textViewDidBeginEditing (_ textView: UITextView) {
		if descriptionTextView.isFirstResponder {
			descriptionTextView.text = nil
			descriptionTextView.textColor = .black
		}
	}
	
	func textViewDidEndEditing (_ textView: UITextView) {
		if descriptionTextView.text.isEmpty || descriptionTextView.text == "" {
			descriptionTextView.textColor = .systemGray4
			descriptionTextView.text = "Type description here..."
		}
	}

}

extension NewNoteViewController: UITextFieldDelegate {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == nameLabel {
			surnameLabel.becomeFirstResponder()
		} else if textField == surnameLabel {
			descriptionTextView.becomeFirstResponder()
		}
		return true
	}
}

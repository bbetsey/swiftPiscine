//
//  ViewController.swift
//  ex01
//
//  Created by Антон Тропин on 23.07.2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var mainLabel: UILabel!
	private var textStatus = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func changeLabelAction() {
		mainLabel.text = textStatus
		? "Hello World !"
		: "Label"
		textStatus.toggle()
	}
	
}


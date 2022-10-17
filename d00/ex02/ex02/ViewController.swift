//
//  ViewController.swift
//  ex02
//
//  Created by Антон Тропин on 23.07.2022.
//

import UIKit

class ViewController: UIViewController {


	@IBOutlet var mainLabel: UILabel!

	private var firstOperand: Int = 0
	private var secondOperand: Int = 0
	private var wasOperation: Bool = false
	private var firstOperandWasUpdated: Bool = false
	private var secondOperandWasUpdated: Bool = false
	private var resultWasCalculated: Bool = false
	private var lastOperation: Action = .empty

	enum Action {
		case sub, add, multiplication, division, empty
		
		func execute(first: Int, second: Int) -> (Int, Bool) {
			switch self {
				case .sub:
					return first.subtractingReportingOverflow(second)
				case .add:
					return first.addingReportingOverflow(second)
				case .multiplication:
					return first.multipliedReportingOverflow(by: second)
				case .division:
					if second == 0 {
						return (0, true)
					}
					return first.dividedReportingOverflow(by: second)
				case .empty:
					return (first, false)
			}
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		.lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mainLabel.text = "0"
	}

	@IBAction func ACAction() {
		print("AC")
		resetData()
		mainLabel.text = "0"
	}
	
	@IBAction func NEGAction() {
		print("neg")
		if !secondOperandWasUpdated || resultWasCalculated {
			let result = firstOperand.multipliedReportingOverflow(by: -1)
			let overflow = result.1
			if overflow {
				mainLabel.text = "overflow"
				resetData()
				return
			}
			firstOperand = result.0
			mainLabel.text = String(firstOperand)
		} else {
			let result = secondOperand.multipliedReportingOverflow(by: -1)
			let overflow = result.1
			if overflow {
				mainLabel.text = "overflow"
				resetData()
				return
			}
			secondOperand = result.0
			mainLabel.text = String(secondOperand)
		}
	}
	
	
	@IBAction func operatorAction(_ sender: UIButton) {
		print(sender.titleLabel?.text ?? "?")
		if wasOperation && secondOperandWasUpdated && !resultWasCalculated {
			resultWasCalculated = false
			let result = lastOperation.execute(
				first: firstOperand,
				second: secondOperand
			)
			let overflow = result.1
			if overflow {
				mainLabel.text = "overflow"
				resetData()
				return
			}
			firstOperand = result.0
			mainLabel.text = String(firstOperand)
		}
		wasOperation = true
		secondOperandWasUpdated = false
		resultWasCalculated = false
		switch sender.tag {
			case 0: lastOperation = .add
			case 1: lastOperation = .sub
			case 2: lastOperation = .multiplication
			case 3: lastOperation = .division
			default: break
		}
	}


	@IBAction func equalAction() {
		print("=")
		if wasOperation {
			if !secondOperandWasUpdated {
				secondOperand = firstOperand
				secondOperandWasUpdated = true
			}
			firstOperandWasUpdated = false
			resultWasCalculated = true
			let result = lastOperation.execute(
				first: firstOperand,
				second: secondOperand
			)
			let overflow = result.1
			if overflow {
				mainLabel.text = "overflow"
				resetData()
				return
			}
			firstOperand = result.0
			mainLabel.text = String(firstOperand)
		}
	}

	@IBAction func NumbersAction(_ sender: UIButton) {
		print(sender.tag)
		if !wasOperation || resultWasCalculated {
			if !firstOperandWasUpdated {
				firstOperandWasUpdated = true
				firstOperand = 0
			}
			if !(firstOperand == 0 && sender.tag == 0) {
				if firstOperand >= 0 {
					guard mainLabel.text?.count ?? 0 < 18 else { return }
					firstOperand = firstOperand * 10 + sender.tag
					mainLabel.text = String(firstOperand)
				} else {
					guard mainLabel.text?.count ?? 0 < 18 else { return }
					firstOperand = firstOperand * 10 - sender.tag
					mainLabel.text = String(firstOperand)
				}
			}
		} else {
			if !secondOperandWasUpdated {
				secondOperandWasUpdated = true
				secondOperand = sender.tag
				mainLabel.text = String(secondOperand)
			} else if !(secondOperand == 0 && sender.tag == 0) {
				if secondOperand >= 0 {
					guard mainLabel.text?.count ?? 0 < 18 else { return }
					secondOperand = secondOperand * 10 + sender.tag
					mainLabel.text = String(secondOperand)
				} else {
					guard mainLabel.text?.count ?? 0 < 18 else { return }
					secondOperand = secondOperand * 10 - sender.tag
					mainLabel.text = String(secondOperand)
				}
			}
		}
	}
	
}


extension ViewController {
	private func resetData() {
		lastOperation = .empty
		firstOperand = 0
		secondOperand = 0
		wasOperation = false
		firstOperandWasUpdated = false
		secondOperandWasUpdated = false
		resultWasCalculated = false
	}
}

//
//  ViewController.swift
//  Siri
//
//  Created by Антон Тропин on 18.08.2022.
//

import UIKit
import RecastAI
import DarkSkyKit

class ViewController: UIViewController {

	@IBOutlet var searchTF: UITextField!
	@IBOutlet var answerLabel: UILabel!
	@IBOutlet var temperatureLabel: UILabel!
	@IBOutlet var windSpeedLabel: UILabel!
	@IBOutlet var temperatureTitleLabel: UILabel!
	@IBOutlet var windSpeedTitleLabel: UILabel!
	
	private let recastToken = "46679084ad498e0988b71041b09929cb"
	private let darkDkyToken = "941ae94104e91e502c1a58efc4177baa"
	
	private var bot: RecastAIClient?
	private var forecastClient: DarkSkyKit?
	private var lng: Double?
	private var lat: Double?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		searchTF.delegate = self
		bot = RecastAIClient(token: recastToken, language: "en")
		forecastClient = DarkSkyKit(apiToken: darkDkyToken)
		
		answerLabel.text = ""
		temperatureLabel.text = ""
		windSpeedLabel.text = ""
		temperatureTitleLabel.isHidden = true
		windSpeedTitleLabel.isHidden = true
	}


	@IBAction func searchButtonPressed() {
		makeRequest(for: searchTF.text)
	}
}


// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == searchTF {
			makeRequest(for: textField.text)
			textField.resignFirstResponder()
		}
		return true
	}
}


// MARK: - Class Methods

extension ViewController {
	
	private func makeRequest(for text: String?) {
		guard let request = text else { return }
		guard request.count > 0 else { return }
		
		bot?.textRequest(request, successHandler: { result in
			self.getWeather(for: result)
		}, failureHandle: { error in
			print(error)
		})
	}
	
	private func getWeather(for response: Response) {
		prepareData(from: response)
		guard let lng = self.lng, let lat = self.lat else {
			temperatureLabel.isHidden = true
			temperatureTitleLabel.isHidden = true
			windSpeedLabel.isHidden = true
			windSpeedTitleLabel.isHidden = true
			return
		}
		
		forecastClient?.current(latitude: lat, longitude: lng, result: { result in
			switch result {
				case .success(let data):
					self.makeAnswer(from: data)
				case .failure(let error):
					print(error.localizedDescription)
			}
		})
	}
	
	private func makeAnswer(from data: Forecast) {
		guard let current = data.currently else { return }
		let summary = current.summary ?? ""
		let temperature = (current.temperature != nil)
		? String(Int((current.temperature! - 32.0) * (5.0/9.0)))
			: "-"
		let windSpeed = (current.windSpeed != nil) ? String(current.windSpeed!) : "-"
		
		temperatureLabel.isHidden = false
		temperatureTitleLabel.isHidden = false
		windSpeedLabel.isHidden = false
		windSpeedTitleLabel.isHidden = false
		
		answerLabel.text = "In \(searchTF.text!.capitalized) \(summary.lowercased()) now."
		temperatureLabel.text = "\(temperature)℃"
		windSpeedLabel.text = windSpeed
		temperatureTitleLabel.isHidden = false
		windSpeedTitleLabel.isHidden = false
	}
	
	private func prepareData(from response: Response) {
		let location = response.get(entity: "location")
		guard let location = location else {
			answerLabel.text = "Error: no location"
			self.lng = nil
			self.lat = nil
			return
		}
		guard let lng = location["lng"] as? Double, let lat = location["lat"] as? Double else {
			answerLabel.text = "Error: no coordinates"
			self.lng = nil
			self.lat = nil
			return
		}
		self.lng = lng
		self.lat = lat
	}
}

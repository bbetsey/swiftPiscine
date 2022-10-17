//
//  ViewController.swift
//  Tweets
//
//  Created by Антон Тропин on 30.07.2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tweetsTableView: UITableView!
	@IBOutlet weak var searchTextField: UITextField!
	
	var tweets: [Tweet]  = []
	var apiController: APIController?
	private let bearerToken = "AAAAAAAAAAAAAAAAAAAAAJKcfQEAAAAA5nVpVTQQuGZqTZNnQsANEy3JorE%3DhETHnoSl5Y5iyiKZ5wpPYHXMH8PvlakqEQwMDKWhkaHxeRXE4N"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.searchTweets(for: "42 ecole")
		tweetsTableView.delegate = self
		tweetsTableView.dataSource = self
		tweetsTableView.allowsSelection = false
		tweetsTableView.rowHeight = UITableView.automaticDimension
		tweetsTableView.separatorStyle = .none
		searchTextField.delegate = self

	}

	private func searchTweets(for searchStr: String) {
		self.apiController = APIController(delegate: self, token: bearerToken)
		self.apiController?.fetchTweets(for: searchStr)
	}

}


// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == searchTextField {
			guard let text = textField.text else { return false }
			if text.isEmpty == false {
				receiveTweets(from: [])
				searchTweets(for: text)
				textField.resignFirstResponder()
				return true
			}
		}
		return false
	}
}


// MARK: - UITableViewDelelate

extension ViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.tweets.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
		cell.configure(for: self.tweets[indexPath.row])
		return cell
	}
	
}


// MARK: - APITwitterDelegate

extension ViewController: APITwitterDelegate {
	func receiveTweets(from tweets: [Tweet]) {
		self.tweets = tweets
		tweetsTableView.reloadData()
	}
	
	func errorHandler(for error: NSError) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	
}

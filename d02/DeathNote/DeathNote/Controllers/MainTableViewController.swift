//
//  MainTableViewController.swift
//  DeathNote
//
//  Created by Антон Тропин on 27.07.2022.
//

import UIKit

class MainTableViewController: UITableViewController {

	private var deathNotes: [DeathNoteModel] = DeathNoteModel.getNotesForTest()

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		deathNotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell", for: indexPath) as! DeathNoteTableViewCell
		let deathNote = deathNotes[indexPath.row]
		cell.fullNameLabel.text = deathNote.fullname
		cell.dateLabel.text = deathNote.date
		cell.descriptionLabel.text = deathNote.description
		cell.paletteView.backgroundColor = .systemGray6
		cell.paletteView.layer.cornerRadius = 15

        return cell
    }

    // MARK: - Navigation
	 
	@IBAction func unwind(for segue: UIStoryboardSegue) {
		guard let newNoteVC = segue.source as? NewNoteViewController else { return }
		guard let name = newNoteVC.nameLabel.text else { return }
		guard let surname = newNoteVC.surnameLabel.text else { return }
		guard name.count > 0 && surname.count > 0 else { return }
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
		let date = dateFormatter.string(from: newNoteVC.datePicker.date)
		let description = newNoteVC.descriptionTextView.text ?? ""
		
		deathNotes.append(
			DeathNoteModel(
				name: name,
				surname: surname,
				date: date,
				description: description)
		)
		tableView.reloadData()
	}

}

//
//  MainCollectionViewController.swift
//  APM
//
//  Created by Антон Тропин on 27.07.2022.
//

import UIKit

private let reuseIdentifier = "photoCell"

class MainCollectionViewController: UICollectionViewController {
	
	let urls: [URL?] = [
		URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/9460197354_907d525c54_o.jpeg"),
		URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/iss067e124176.jpg"),
		URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/lc09_l1tp_013042_20220118_b432_bahamas1x1.jpeg"),
		URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/pia25450.jpeg"),
		URL(string: "https://vk.com/404")
	]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let detailVC = segue.destination as? DetailPhotoViewController else { return }
		guard let cell = sender as? PhotoCollectionViewCell else { return }
		detailVC.photo = cell.photoImageView.image
	}

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		urls.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
		cell.layer.cornerRadius = 5
		cell.backgroundColor = .systemGray6
		cell.indicator.startAnimating()
		cell.indicator.isHidden = false
		guard let url = urls[indexPath.row] else {
			cell.indicator.stopAnimating()
			cell.isHidden = true
			showAlert(with: "Error", and: "can't download pucture")
			return cell
		}
		let queue = DispatchQueue.global(qos: .utility)
		queue.async {
			guard let imageData = try? Data(contentsOf: url) else {
				DispatchQueue.main.async {
					self.showAlert(with: "Error", and: "can't download pucture")
					cell.photoImageView.image = UIImage(named: "noPhoto")
					cell.indicator.stopAnimating()
					cell.indicator.isHidden = true
				}
				return
			}
			DispatchQueue.main.async {
				cell.photoImageView.image = UIImage(data: imageData)
				cell.indicator.stopAnimating()
				cell.indicator.isHidden = true
			}
		}
		return cell
    }
	
	private func showAlert(with title: String, and message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
}


extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let itemsPerRow: CGFloat = 2
		let paddingWidth = 16 * (itemsPerRow + 1)
		let availableWidth = collectionView.frame.width - paddingWidth
		let widthPerItem = availableWidth / itemsPerRow
		return CGSize(width: widthPerItem, height: widthPerItem)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		16
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		16
	}
}

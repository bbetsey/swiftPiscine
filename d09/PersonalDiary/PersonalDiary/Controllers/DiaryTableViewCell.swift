//
//  DiaryTableViewCell.swift
//  PersonalDiary
//
//  Created by Антон Тропин on 22.08.2022.
//

import UIKit
import bbetsey2022

class DiaryTableViewCell: UITableViewCell {
	
	@IBOutlet weak var coverImage: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!
	@IBOutlet weak var createdAtLabel: UILabel!
	@IBOutlet weak var updatedAtLabel: UILabel!
	@IBOutlet weak var imagePalette: UIView!
	
	
	func updateCell(with article: Article) {
		
		titleLabel.text = article.title
		contentLabel.text = article.content
		
		let createdAt: String = formatDate(date: article.created_at!)
		let udpatedAt: String = formatDate(date: article.updated_at!)
		
		createdAtLabel.text = "\(createdAt)"
		if article.created_at != article.updated_at {
			updatedAtLabel.isHidden = false
			updatedAtLabel.text = "UPD: \(udpatedAt)"
		} else {
			updatedAtLabel.isHidden = true
		}
		coverImage.layer.cornerRadius = 10
		
		// Image shadow configuration
		imagePalette.layer.shadowColor = UIColor.black.cgColor
		imagePalette.layer.shadowOpacity = 0.5
		imagePalette.layer.shadowOffset = .init(width: 10, height: 10)
		imagePalette.layer.shadowRadius = 10
		imagePalette.layer.shadowPath = UIBezierPath(rect: coverImage.bounds).cgPath
		imagePalette.layer.shouldRasterize = true
		imagePalette.layer.rasterizationScale = UIScreen.main.scale
		
		guard let image = article.image else {
			coverImage.image = UIImage(named: "cover 1")
			return
		}
		coverImage.image = UIImage(data: image)
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	private func formatDate(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy HH:mm"
		let formattedDate = formatter.string(from: date)
		
		return formattedDate
	}

}

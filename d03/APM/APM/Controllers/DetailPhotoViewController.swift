//
//  DetailPhotoViewController.swift
//  APM
//
//  Created by Антон Тропин on 30.07.2022.
//

import UIKit

class DetailPhotoViewController: UIViewController {

	var photo: UIImage?
	var imageScrollView: ImageScrollView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		imageScrollView = ImageScrollView(frame: view.bounds)
		view.addSubview(imageScrollView)
		setupImageScrollView()
		
		guard let image = photo else { return }
		self.imageScrollView.set(image: image)
    }
	
	func setupImageScrollView() {
		imageScrollView.translatesAutoresizingMaskIntoConstraints = false
		imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
    
}

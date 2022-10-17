//
//  ImageScrollView.swift
//  APM
//
//  Created by Антон Тропин on 30.07.2022.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {

	var imageZoomView: UIImageView!
	lazy var zoomingTap: UITapGestureRecognizer = {
		let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
		zoomingTap.numberOfTapsRequired = 2
		return zoomingTap
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.delegate = self
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(image: UIImage) {
		if imageZoomView != nil {
			imageZoomView.removeFromSuperview()
			imageZoomView = nil
		}
		imageZoomView = UIImageView(image: image)
		self.addSubview(imageZoomView)
		configurateFor(imageSize: image.size)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.centerImage()
	}
	
	func configurateFor(imageSize: CGSize) {
		self.contentSize = imageSize
		setCurrentMaxAndMinZoomScale()
		self.zoomScale = self.minimumZoomScale
		self.imageZoomView.addGestureRecognizer(self.zoomingTap)
		self.imageZoomView.isUserInteractionEnabled = true
	}
	
	func setCurrentMaxAndMinZoomScale() {
		let boundsSize = self.bounds.size
		let imageSize = imageZoomView.bounds.size
		
		let xScale = boundsSize.width / imageSize.width
		let yScale = boundsSize.height / imageSize.height
		let minScale = min(xScale, yScale)
		
		var maxScale: CGFloat = 1.0
		if minScale < 0.1 {
			maxScale = 0.3
		} else if minScale >= 0.1 && minScale < 0.5 {
			maxScale = 0.7
		} else {
			maxScale = max(1.0, minScale)
		}
		self.maximumZoomScale = maxScale
		self.minimumZoomScale = minScale
	}
	
	func centerImage() {
		guard let imageZoomView = self.imageZoomView else { return }
		let boundsSize = self.bounds.size
		var frameToCenter = imageZoomView.frame
		
		if frameToCenter.size.width < boundsSize.width {
			frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 3.5
		} else {
			frameToCenter.origin.x = 0
		}
		
		if frameToCenter.size.height < boundsSize.height {
			frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 3.5
		} else {
			frameToCenter.origin.y = 0
		}
		
		imageZoomView.frame = frameToCenter
	}
	
	
	// MARK: - Gesture

	@objc func handleZoomingTap(sender: UITapGestureRecognizer) {
		let location = sender.location(in: sender.view)
		self.zoom(point: location, animated: true)
	}
	
	func zoom(point: CGPoint, animated: Bool) {
		let currectScale = self.zoomScale
		let minScale = self.minimumZoomScale
		let maxScale = self.maximumZoomScale
		
		if minScale == maxScale && minScale > 1.0 {
			return
		}

		let toScale = maxScale
		let finalScale = (currectScale == minScale) ? toScale : minScale
		let zoomRect = self.zoomRect(scale: finalScale, center: point)
		self.zoom(to: zoomRect, animated: animated)
	}

	func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
		var zoomRect = CGRect.zero
		let bounds = self.bounds
		
		zoomRect.size.width = bounds.size.width / scale
		zoomRect.size.height = bounds.size.height / scale
		
		zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
		zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
		return zoomRect
	}

	
	// MARK: - UIScrollViewDelegate
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		self.imageZoomView
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		self.centerImage()
	}

}

//
//  Shape.swift
//  MotionCube
//
//  Created by Антон Тропин on 08.08.2022.
//

import UIKit


enum Shapes {
	case circle, square
	static let allShapes = [circle, square]
}

class Shape: UIView {
	let shape: Shapes
	let color: UIColor
	var path: UIBezierPath!
	var oldBounds: CGRect!
	
	
	override init(frame: CGRect) {
		self.shape = Shapes.allShapes.randomElement()!
		self.color = UIColor.getRandomCustomColor()
		super.init(frame: frame)
		self.oldBounds = self.bounds
		self.backgroundColor = UIColor(white: 1, alpha: 0)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		self.path = (self.shape == .circle)
			? UIBezierPath(ovalIn: rect)
			: UIBezierPath(rect: rect)
		self.color.setFill()
		path.fill()
	}
	
	override public var collisionBoundsType: UIDynamicItemCollisionBoundsType {
		.path
	}
	
	override public var collisionBoundingPath: UIBezierPath {
		if self.shape == .circle {
			let radius = min(self.bounds.size.width, self.bounds.size.height) / 2.0
			return UIBezierPath(arcCenter: CGPoint.zero,
								radius: radius,
								startAngle: 0,
								endAngle: CGFloat(Double.pi * 2.0),
								clockwise: true)
		} else {
			return UIBezierPath(rect: CGRect(x: -self.bounds.width / 2,
											 y:  -self.bounds.height / 2,
											 width: self.bounds.width,
											 height: self.bounds.height))
		}
	}
}

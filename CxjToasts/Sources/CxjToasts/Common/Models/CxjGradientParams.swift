//
//  CxjGradientParams.swift
//
//
//  Created by Nikita Begletskiy on 19/10/2024.
//

import UIKit

public struct CxjGradientParams {
	let colors: [UIColor]
	let locations: [Double]?
	let direction: Direction
	
	public init(
		colors: [UIColor],
		locations: [Double]?,
		direction: Direction
	) {
		self.colors = colors
		self.locations = locations
		self.direction = direction
	}
}

//MARK: - Direction
extension CxjGradientParams {
	public struct Direction {
		let startPoint: CGPoint
		let endPoint: CGPoint
		
		public init(
			startPoint: CGPoint,
			endPoint: CGPoint
		) {
			self.startPoint = startPoint
			self.endPoint = endPoint
		}
	}
}

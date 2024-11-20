//
//  CxjToastGradientBackgroundView.swift
//  
//
//  Created by Nikita Begletskiy on 19/10/2024.
//

import UIKit

//MARK: - Types
extension CxjToastGradientBackgroundView {
	struct GradientState {
		let colors: [CGColor]
		let startPoint: CGPoint
		let endPoint: CGPoint
		let locations: [NSNumber]?
	}
}

final class CxjToastGradientBackgroundView: UIView {
	//MARK: - Sublayers
	private var gradientLayer: CALayer?
	
	//MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		baseConfigure()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		baseConfigure()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		updateGradientLayout()
	}
}

//MARK: - Public
extension CxjToastGradientBackgroundView {
	func updateGradientState(_ state: GradientState) {
		resetGradientLayerWithState(state)
	}
}

//MARK: - Layout
private extension CxjToastGradientBackgroundView {
	func updateGradientLayout() {
		gradientLayer?.frame = bounds
	}
}

//MARK: - Gradient setup
private extension CxjToastGradientBackgroundView {
	func resetGradientLayerWithState(_ gradientState: GradientState) {
		removeGradientLayer()
		
		let gradientLayer: CAGradientLayer = createGradientLayerWithState(gradientState)
		
		self.gradientLayer = gradientLayer
		layer.insertSublayer(gradientLayer, at: 0)
		updateGradientLayout()
	}
	
	func removeGradientLayer() {
		gradientLayer?.removeFromSuperlayer()
		gradientLayer = nil
	}
}

//MARK: - GradientLayer creation
private extension CxjToastGradientBackgroundView {
	func createGradientLayerWithState(_ state: GradientState) -> CAGradientLayer {
		let gradientLayer = CAGradientLayer()
		
		gradientLayer.colors = state.colors
		gradientLayer.startPoint = state.startPoint
		gradientLayer.endPoint = state.endPoint
		gradientLayer.locations = state.locations
		
		return gradientLayer
	}
}

//MARK: - Base configuration
private extension CxjToastGradientBackgroundView {
	func baseConfigure() {
		backgroundColor = .clear
	}
}

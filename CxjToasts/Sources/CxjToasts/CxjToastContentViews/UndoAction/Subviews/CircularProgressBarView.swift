//
//  CircularProgressBarView.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 24/11/2024.
//

import UIKit

//MARK: - Types
extension CircularProgressBarView {
	struct Appearance {
		let lineWidth: CGFloat
		let backgroundColor: UIColor
		let progressColor: UIColor
	}
}

final class CircularProgressBarView: UIView {
	// MARK: - SubLayers
	private let progressLayer: CAShapeLayer = CAShapeLayer()
	private let backgroundLayer: CAShapeLayer = CAShapeLayer()
	
	//MARK: - Props
	private var appearance: Appearance //= Appearance(lineWidth: 2.0, backgroundColor: .white, progressColor: .black)

	// MARK: - Lifecycle
	init(appearance: Appearance, frame: CGRect = .zero) {
		self.appearance = appearance
		super.init(frame: frame)
		
		baseConfigure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		updateSublayersLayout()
	}
}

//MARK: - Appearance updating
extension CircularProgressBarView {
	func updateAppearance(_ appearance: Appearance) {
		[backgroundLayer, progressLayer].forEach { $0.lineWidth = appearance.lineWidth }
		backgroundLayer.strokeColor = appearance.backgroundColor.cgColor
		progressLayer.strokeColor = appearance.progressColor.cgColor
	}
}

//MARK: - Progress Updating
extension CircularProgressBarView {
	func setProgress(_ progress: CGFloat, animated: Bool) {
		let clampedProgress = max(min(progress, 1), 0)

		if animated {
			let animation = CABasicAnimation(keyPath: "strokeEnd")
			animation.fromValue = progressLayer.presentation()?.strokeEnd ?? progressLayer.strokeEnd
			animation.toValue = clampedProgress
			animation.duration = 0.25
			animation.timingFunction = CAMediaTimingFunction(name: .linear)
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			
			progressLayer.add(animation, forKey: "progress")
		}

		progressLayer.strokeEnd = clampedProgress
	}
}

//MARK: - Layers Layout
private extension CircularProgressBarView {
	func updateSublayersLayout() {
		let circlePath = UIBezierPath(
			arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
			radius: (bounds.width - appearance.lineWidth) / 2,
			startAngle: -CGFloat.pi / 2,
			endAngle: CGFloat.pi * 3 / 2,
			clockwise: true
		).cgPath

		backgroundLayer.path = circlePath
		progressLayer.path = circlePath
	}
}

//MARK: - Base Configuration
private extension CircularProgressBarView {
	func baseConfigure() {
		addSublayers()
		configureSubLayer(backgroundLayer, strokeEnd: 1.0)
		configureSubLayer(progressLayer, strokeEnd: .zero)
		updateAppearance(appearance)
	}
	
	func addSublayers() {
		layer.addSublayer(backgroundLayer)
		layer.addSublayer(progressLayer)
	}
	
	func configureSubLayer(_ layer: CAShapeLayer, strokeEnd: CGFloat) {
		layer.lineCap = .round
		layer.strokeStart = .zero
		layer.strokeEnd = strokeEnd
		layer.fillColor = UIColor.clear.cgColor
	}
}

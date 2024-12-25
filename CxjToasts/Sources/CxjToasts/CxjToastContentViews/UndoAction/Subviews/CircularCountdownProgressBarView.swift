//
//  CircularCountdownProgressBarView.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 24/11/2024.
//

import UIKit

//MARK: - Types
extension CircularCountdownProgressBarView {
	struct Appearance {
		let lineWidth: CGFloat
		let progressColor: UIColor
	}
}

final class CircularCountdownProgressBarView: UIView {
	// MARK: - SubLayers
	private let progressLayer: CAShapeLayer = CAShapeLayer()
	private let maskLayer: CAShapeLayer = CAShapeLayer()
	
	//MARK: - Props
	private var appearance: Appearance
	
	private var isInitialProgressSetted: Bool = false

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
		
		if bounds != .zero {
			setInitialProgressIfNeeded()
		}
	}
}

//MARK: - Appearance updating
extension CircularCountdownProgressBarView {
	func updateAppearance(_ appearance: Appearance) {
		[progressLayer].forEach { $0.lineWidth = appearance.lineWidth }
		progressLayer.strokeColor = appearance.progressColor.cgColor
	}
}

//MARK: - Progress Updating
extension CircularCountdownProgressBarView {
	func setProgress(_ progress: CGFloat, animated: Bool) {
		let clampedProgress = max(min(progress, 1), 0)
		
		let cgPath: CGPath = maskPathInsideRect(bounds, lineWidth: progressLayer.lineWidth, fillingProgress: clampedProgress).cgPath
		
		if animated {
			let animation: CABasicAnimation = CABasicAnimation(keyPath: "path")
			animation.fromValue = maskLayer.path
			animation.toValue = cgPath
			animation.duration = 0.5
			animation.timingFunction = CAMediaTimingFunction(name: .linear)
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			
			maskLayer.add(animation, forKey: "progress_mask")
			
			maskLayer.path = cgPath
		} else {
			maskLayer.removeAllAnimations()
			maskLayer.path = cgPath
		}
	}
	
	private func setInitialProgressIfNeeded() {
		guard !isInitialProgressSetted else { return }
		
		isInitialProgressSetted = true
		setProgress(.zero, animated: false)
	}
}

//MARK: - Mask path calculation
private extension CircularCountdownProgressBarView {
	func maskPathInsideRect(_ maskRect: CGRect, lineWidth: CGFloat,  fillingProgress: CGFloat) -> UIBezierPath {
		let radius = (maskRect.width + lineWidth) / 2
		let center = CGPoint(x: maskRect.midX, y: maskRect.midY)
		let startAngle = -CGFloat.pi / 2
		let endAngle = startAngle + (2 * .pi * fillingProgress)
		
		let fullCirclePath = UIBezierPath(
			arcCenter: center,
			radius: radius,
			startAngle: startAngle,
			endAngle: startAngle + 2 * .pi,
			clockwise: true
		)
		
		let progressPath = UIBezierPath(
			arcCenter: center,
			radius: radius,
			startAngle: startAngle,
			endAngle: endAngle,
			clockwise: true
		)
		
		progressPath.addLine(to: center)
		progressPath.close()
		
		fullCirclePath.append(progressPath)
		
		return fullCirclePath
	}
	
	func progressLayerPathInsideRect(_ progressRect: CGRect, lineWidth: CGFloat) -> UIBezierPath {
		let circlePath = UIBezierPath(
			arcCenter: CGPoint(x: progressRect.midX, y: progressRect.midY),
			radius: (progressRect.width - lineWidth) / 2,
			startAngle: -CGFloat.pi / 2,
			endAngle: CGFloat.pi * 3 / 2,
			clockwise: true
		)
		
		return circlePath
	}
}

//MARK: - Layers Layout
private extension CircularCountdownProgressBarView {
	func updateSublayersLayout() {
		let circlePath = progressLayerPathInsideRect(bounds, lineWidth: appearance.lineWidth)
		
		progressLayer.path = circlePath.cgPath
	}
}

//MARK: - Base Configuration
private extension CircularCountdownProgressBarView {
	func baseConfigure() {
		addSublayers()
		configureProgressLayer()
		configureMaskLayer()
		updateAppearance(appearance)
	}
	
	func addSublayers() {
		layer.addSublayer(progressLayer)
	}
	
	func configureProgressLayer() {
		progressLayer.lineCap = .round
		progressLayer.strokeStart = .zero
		progressLayer.strokeEnd = 1.0
		progressLayer.fillColor = UIColor.clear.cgColor
	}
	
	func configureMaskLayer() {
		maskLayer.fillRule = .evenOdd
		maskLayer.fillColor = UIColor.black.cgColor
		progressLayer.mask = maskLayer
	}
}

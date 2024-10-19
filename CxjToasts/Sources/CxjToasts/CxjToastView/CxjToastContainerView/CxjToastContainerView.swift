//
//  CxjToastView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastContainerView {
	struct ViewState {
		enum Shadow {
			case enabled(params: CxjUIViewShadowParams)
			case disabled
		}
		
		struct Corners {
			enum CornersType {
				case capsule
				case fixed(value: CGFloat)
			}
			
			let type: CornersType
			let mask: CACornerMask
		}
		
		let contentInsets: UIEdgeInsets
		let shadow: Shadow
		let corners: Corners
	}
}

final class CxjToastContainerView: UIView {
    //MARK: - Subviews
    private let contentView: UIView
	private let backgroundView: UIView
	
    //MARK: - Props
	private let state: ViewState
	
    //MARK: - Lifecycle
	public init(
		state: ViewState,
		contentView: UIView,
		backgroundView: UIView
	) {
		self.state = state
		self.contentView = contentView
		self.backgroundView = backgroundView
		
        super.init(frame: .zero)
        
        baseConfigure()
		updateUIForState(state)
	}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		backgroundView.layer.cornerRadius = layer.cornerRadius
	}
}

//MARK: - CxjToastView
extension CxjToastContainerView: CxjToastView {
	func prepareToDisplay() {
		updateUIForState(state)
	}
}

//MARK: - Configuration
private extension CxjToastContainerView {
	func updateUIForState(_ state: ViewState) {
		setupCorners(state.corners)
		setupShadow(state.shadow)
	}
	
	func setupShadow(_ shadow: ViewState.Shadow) {
		switch shadow {
		case .disabled:
			return
		case .enabled(params: let params):
			setupShadowWithParams(params)
		}
	}
	
	func setupCorners(_ corners: ViewState.Corners) {
		switch corners.type {
		case .capsule: layer.cornerRadius = bounds.size.height * 0.5
		case .fixed(let value): layer.cornerRadius = value
		}
		
		layer.maskedCorners = corners.mask
		clipsToBounds = true
	}
}

//MARK: - Base Configuration
private extension CxjToastContainerView {
    func baseConfigure() {
		setupBackgroundView()
		setupContentView(withInsets: state.contentInsets)
    }
	
	func setupBackgroundView() {
		addSubview(backgroundView)
		backgroundView.clipsToBounds = true
		backgroundView.frame = bounds
		backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}
	
	func setupContentView(withInsets insets: UIEdgeInsets) {
		addSubview(contentView)
		contentView.backgroundColor = .clear
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
		])
	}
}

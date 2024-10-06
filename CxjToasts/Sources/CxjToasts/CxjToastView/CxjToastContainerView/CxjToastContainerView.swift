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
				case rounded(value: CGFloat)
			}
			
			let type: CornersType
			let mask: CACornerMask
		}
		
		let contentInsets: UIEdgeInsets
		let backgroundColor: UIColor
		let shadow: Shadow
		let corners: Corners
	}
}

final class CxjToastContainerView: UIView {
    //MARK: - Subviews
    private let contentView: UIView
    //MARK: - Props
	private let state: ViewState
	
    //MARK: - Lifecycle
	public init(
		state: ViewState,
		contentView: UIView
	) {
		self.state = state
		self.contentView = contentView
        
        super.init(frame: .zero)
        
        baseConfigure()
		updateUIForState(state)
	}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - CxjToastView
extension CxjToastContainerView: CxjToastView {
	func prepareToDisplay() {
		setupShadow(state.shadow)
		setupCorners(state.corners)
	}
}

//MARK: - Configuration
private extension CxjToastContainerView {
	func updateUIForState(_ state: ViewState) {
		setupContentLayoutWithInsets(state.contentInsets)
		backgroundColor = state.backgroundColor
		setupShadow(state.shadow)
		setupCorners(state.corners)
	}
	
	func setupContentLayoutWithInsets(_ insets: UIEdgeInsets) {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
		])
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
		case .rounded(let value): layer.cornerRadius = value
		}
		
		layer.maskedCorners = corners.mask
	}
}

//MARK: - Base Configuration
private extension CxjToastContainerView {
    func baseConfigure() {
		clipsToBounds = true
		
        addSubview(contentView)
    }
}

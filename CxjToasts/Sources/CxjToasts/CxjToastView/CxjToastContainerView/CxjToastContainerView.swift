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
        
        typealias Layout = CxjToastContentLayout
		
        let contentLayout: Layout
		let shadow: Shadow
		let corners: Corners
	}
}

final class CxjToastContainerView: UIView {
    //MARK: - Subviews
    private let contentView: CxjToastContentView
	private let backgroundView: UIView
	
    //MARK: - Props
	private let state: ViewState
	
    //MARK: - Lifecycle
	public init(
		state: ViewState,
		contentView: CxjToastContentView,
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
		
        updateCornersForState(state.corners)
	}
}

//MARK: - CxjToastView
extension CxjToastContainerView: CxjToastView {
	func prepareToDisplay() {
		updateUIForState(state)
	}
	
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {
		contentView.updateForRemainingDisplayingTime(time, animated: animated)
	}
	
	func updateForDismissingProgress(_ progress: Float, animated: Bool) {
		contentView.updateForDismissingProgress(progress, animated: animated)
	}
}

//MARK: - Configuration
private extension CxjToastContainerView {
	func updateUIForState(_ state: ViewState) {
		updateCornersForState(state.corners)
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
	
	func updateCornersForState(_ corners: ViewState.Corners) {
        let cornerRadius: CGFloat
		switch corners.type {
		case .capsule: cornerRadius = bounds.size.height * 0.5
		case .fixed(let value): cornerRadius = value
		}
		
        [layer, backgroundView.layer].forEach {
            $0.cornerRadius = cornerRadius
            $0.maskedCorners = corners.mask
        }
	}
}

//MARK: - Base Configuration
private extension CxjToastContainerView {
    func baseConfigure() {
        clipsToBounds = true
        contentView.backgroundColor = .clear
        
        setupBackgroundView()
        setupContentViewWithLayout(state.contentLayout)
    }
	
	func setupBackgroundView() {
		addSubview(backgroundView)
		backgroundView.clipsToBounds = true
		backgroundView.frame = bounds
		backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}
    
    func setupContentViewWithLayout(_ layout: ViewState.Layout) {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = ToastContentNsLayoutConstraintConfigurator
            .constraintsForLayout(
                layout,
                forView: contentView,
                insideView: self
            )
        
        NSLayoutConstraint.activate(constraints)
    }
}

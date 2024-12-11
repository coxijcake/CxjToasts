//
//  CxjActionToastContentView.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 05/12/2024.
//

import UIKit

//MARK: - Types
extension CxjActionToastContentView {
	struct Config {
		struct Layout {
			enum ActionControlPlacement {
				case left, top, right, bottom
			}
			
			let controlPlacement: ActionControlPlacement
			let paddingToContentView: CGFloat
		}
		
		let layout: Layout
	}
}

//MARK: - ContentView
public final class CxjActionToastContentView: UIStackView {
	//MARK: - Subview
	private let contentView: UIView
	private let actionControl: UIControl
	
	//MARK: - Lifecycle
	init(
		contentView: UIView,
		actionControl: UIControl,
		viewConfig: Config,
		frame: CGRect = .zero
	) {
		self.contentView = contentView
		self.actionControl = actionControl
		
		super.init(frame: frame)
		
		baseConfigure()
		configureWithState(viewConfig)
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - View configuration
private extension CxjActionToastContentView {
	func configureWithState(_ viewState: Config) {
		setupAxisForControlPlacement(viewState.layout.controlPlacement)
		setupArrangedSubviewsForControlPlacement(viewState.layout.controlPlacement)
		
		spacing = viewState.layout.paddingToContentView
	}
	
	func setupArrangedSubviewsForControlPlacement(_ placement: Config.Layout.ActionControlPlacement) {
		arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		let orderedSubviews: [UIView]
		switch placement {
		case .left, .top: orderedSubviews = [actionControl, contentView]
		case .right, .bottom: orderedSubviews = [contentView, actionControl]
		}
		
		orderedSubviews.forEach { addArrangedSubview($0) }
	}
	
	func setupAxisForControlPlacement(_ placement: Config.Layout.ActionControlPlacement) {
		switch placement {
		case .left, .right: axis = .horizontal
		case .top, .bottom: axis = .vertical
		}
	}
}

//MARK: - CxjToastContentView
extension CxjActionToastContentView: CxjToastContentView {
	public func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {}
	public func updateForDismissingProgress(_ progress: Float, animated: Bool) {}
}

//MARK: - Base configuration
private extension CxjActionToastContentView {
	func baseConfigure() {
		distribution = .equalSpacing
		alignment = .fill
	}
}

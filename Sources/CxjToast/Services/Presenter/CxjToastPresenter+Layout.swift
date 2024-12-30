//
//  CxjToastPresenter+Layout.swift
//  
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

extension CxjToastPresenter {
	@MainActor
	final class LayoutApplier {
		//MARK: - Types
		typealias ToastLayout = CxjToastConfiguration.Layout
		typealias ToastView = CxjToastView
		typealias ToastConfig = CxjToastConfiguration
		
		//MARK: - Props
		private let toastView: ToastView
		private let sourceView: UIView
		
		private let updatingForKeyboardStrategy: UpdatingForKeyboardStrategy
		
		private var defaultVerticalConstraint: NSLayoutConstraint?
		private var bottomConstaintDuringKeyboardDisplaying: NSLayoutConstraint?
		
		//MARK: - Lifecycle
		init(
			toastView: ToastView,
			sourceView: UIView,
			updatingForKeyboardStrategy: UpdatingForKeyboardStrategy
		) {
			self.toastView = toastView
			self.sourceView = sourceView
			self.updatingForKeyboardStrategy = updatingForKeyboardStrategy
		}
		
		//MARK: - Public API
		func applyToastLayout(
			_ layout: ToastLayout,
			keyboardState: CxjKeyboardDisplayingState
		) {
			let constraints = layout.constraints
			let placement = layout.placement
			
			sourceView.addSubview(toastView)
			toastView.translatesAutoresizingMaskIntoConstraints = false
			
			let verticalAnchorConstraint: NSLayoutConstraint = verticalAnchorConstraint(
				for: toastView,
				placement: placement,
				in: sourceView
			)
			
			self.defaultVerticalConstraint = verticalAnchorConstraint
			
			NSLayoutConstraint.activate([
				toastView.widthAnchor.constraint(greaterThanOrEqualToConstant: constraints.width.min),
				toastView.widthAnchor.constraint(lessThanOrEqualToConstant: constraints.width.max),
				toastView.heightAnchor.constraint(greaterThanOrEqualToConstant: constraints.height.min),
				toastView.heightAnchor.constraint(lessThanOrEqualToConstant: constraints.height.max),
				toastView.leadingAnchor.constraint(greaterThanOrEqualTo: sourceView.safeAreaLayoutGuide.leadingAnchor),
				toastView.trailingAnchor.constraint(lessThanOrEqualTo: sourceView.safeAreaLayoutGuide.trailingAnchor),
				toastView.centerXAnchor.constraint(equalTo: sourceView.centerXAnchor),
				verticalAnchorConstraint
			])
			
			sourceView.layoutIfNeeded()
			toastView.layoutIfNeeded()
			
			updateLayoutForKeyboardState(keyboardState, animated: false)
		}
		
		func applyLayoutForBackgroundView(
			_ backgroundView: UIView,
			inSourceView sourceView: UIView
		) {
			sourceView.addSubview(backgroundView)
			backgroundView.frame = sourceView.bounds
			backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		}
		
		func updateLayoutForKeyboardState(_ keyboardState: CxjKeyboardDisplayingState, animated: Bool) {
			let action = updatingForKeyboardStrategy.actionForState(keyboardState)
			
			guard shouldUpdateForAction(action) else { return }
			
			switch action {
			case .defaultPosition:
				bottomConstaintDuringKeyboardDisplaying?.isActive = false
				bottomConstaintDuringKeyboardDisplaying = nil
				defaultVerticalConstraint?.isActive = true
			case .setupBottomPadding(params: let params):
				defaultVerticalConstraint?.isActive = false
				bottomConstaintDuringKeyboardDisplaying = bottomConstraintForWithPadding(
					params.padding,
					insideView: sourceView
				)
				bottomConstaintDuringKeyboardDisplaying?.isActive = true
				
				let layoutSourceAction: CxjVoidCompletion = {
					self.sourceView.layoutSubviews()
				}
				
				if animated {
					UIView.animate(
						withDuration: params.animationValues.duration,
						delay: .zero,
						options: UIView.AnimationOptions(rawValue: params.animationValues.curveValue),
						animations: layoutSourceAction
					)
				} else {
					layoutSourceAction()
				}
			}
		}
		
		//MARK: - Private API
		private func verticalAnchorConstraint(
			for toastView: ToastView,
			placement: ToastLayout.Placement,
			in sourceView: UIView
		) -> NSLayoutConstraint {
			switch placement {
			case .top(params: let params):
				if params.includingSafeArea {
					toastView.topAnchor
						.constraint(equalTo: sourceView.safeAreaLayoutGuide.topAnchor, constant: params.offset)
				} else {
					toastView.topAnchor
						.constraint(equalTo: sourceView.topAnchor, constant: params.offset)
				}
			case .center:
				toastView.centerYAnchor.constraint(equalTo: sourceView.centerYAnchor)
			case .bottom(params: let params):
				if params.includingSafeArea {
					toastView.bottomAnchor
						.constraint(equalTo: sourceView.safeAreaLayoutGuide.bottomAnchor, constant: -params.offset)
				} else {
					toastView.bottomAnchor
						.constraint(equalTo: sourceView.bottomAnchor, constant: -params.offset)
				}
			}
		}
		
		private func shouldUpdateForAction(_ action: UpdatingForKeyboardStrategy.Action) -> Bool {
			switch action {
			case .defaultPosition:
				bottomConstaintDuringKeyboardDisplaying?.isActive == true
			case .setupBottomPadding(_):
				defaultVerticalConstraint?.isActive == true
			}
		}
		
		private func bottomConstraintForWithPadding(
			_ padding: CGFloat,
			insideView sourceView: UIView
		) -> NSLayoutConstraint {
			return toastView.bottomAnchor.constraint(equalTo: sourceView.bottomAnchor, constant: -padding)
		}
	}
}

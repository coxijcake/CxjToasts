//
//  CxjDisplayingToastsCoordinator.swift
//
//
//  Created by Nikita Begletskiy on 03/11/2024.
//

import UIKit

//MARK: - Types
extension CxjDisplayingToastsCoordinator {
	typealias Toast = any CxjDisplayableToast
	typealias Animation = CxjAnimation
}

//MARK: - Toats Layout
enum CxjDisplayingToastsCoordinator {
	static func updateLayoutFor(
		displayingToasts: [Toast],
		linkedToToast targetToast: Toast,
		withProgress progress: CGFloat,
		animation: Animation,
		completion: CxjBoolCompletion?
	) {
		
		let animatingAction: CxjVoidCompletion = {
			switch targetToast.config.displayingBehaviour.action {
			case .stack(let maxVisibleToasts):
				let toastsToStack: [Toast] = linkedToastsToToast(
					targetToast,
					fromActiveToasts: displayingToasts,
					includingTargetToast: true
				)
				
				CxjDisplayingToastsUpdater.stackLayoutToasts(
					toastsToStack: toastsToStack,
					progress: progress,
					maxVisibleToasts: maxVisibleToasts
				)
			case .hide:
				let toastsToAlphaUpdate: [Toast] = linkedToastsToToast(
					targetToast,
					fromActiveToasts: displayingToasts,
					includingTargetToast: true
				)
				
				CxjDisplayingToastsUpdater.updateAlphaForToasts(
					toastsToAlphaUpdate,
					progress: progress
				)
			case .dismiss:
				guard targetToast.displayingState == .presenting else { return }
				
				let toastsToDismiss: [Toast] = linkedToastsToToast(
					targetToast,
					fromActiveToasts: displayingToasts,
					includingTargetToast: false
				)
				
				CxjToastsCoordinator.shared.dismissToasts(
					toastsToDismiss,
					animated: true
				)
			}
		}
		
		UIView.animate(
			with: animation,
			animations: animatingAction,
			completion: completion
		)
	}
}

//MARK: - DisplayingState updating
extension CxjDisplayingToastsCoordinator {
	static func updateDismissMethodsFor(
		displayingToasts: [Toast],
		linkedToToast targetToast: Toast
	) {
		let toastsToUpdate: [Toast] = linkedToastsToToast(
			targetToast,
			fromActiveToasts: displayingToasts,
			includingTargetToast: true
		)
		
		toastsToUpdate
			.enumerated()
			.forEach { index, toast in
				updateDismissMethodsFor(toast: toast, at: index)
			}
	}
	
	private static func updateDismissMethodsFor(
		toast: Toast,
		at index: Int
	) {
		let isTopPositionToast: Bool = index != 0
		
		isTopPositionToast
		? toast.dismisser.deactivateDismissMethods()
		: toast.dismisser.activateDismissMethods()
	}
}

//MARK: - Toasts to update filtering
private extension CxjDisplayingToastsCoordinator {
	static func linkedToastsToToast(
		_ targetToast: Toast,
		fromActiveToasts activeToasts: [Toast],
		includingTargetToast: Bool
	) -> [Toast] {
		activeToasts
			.filter { activeToast in
				if !includingTargetToast,
				   targetToast.id == activeToast.id {
					return false
				}
				
				let comparingAttributes = targetToast.config.displayingBehaviour.comparingAttributes
				
				var isLinked: Bool = false
				
				for comparingAttribute in comparingAttributes {
					switch comparingAttribute {
					case .type:
						isLinked = ToastTypeComparator(
							lhsToast: activeToast,
							rhsToast: targetToast
						).isEqual()
					case .placement(let includingYOffset):
						let placementComparator = ToastPlacementComparator(
							lhs: activeToast.config.layout.placement,
							rhs: targetToast.config.layout.placement
						)
						
						isLinked = includingYOffset
						? placementComparator.isFullyEqauls()
						: placementComparator.isEqualPlacementType()
					}
				}
				
				return isLinked
			}
			.reversed()
	}
}

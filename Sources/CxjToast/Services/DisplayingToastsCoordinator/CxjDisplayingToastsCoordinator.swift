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
@MainActor
enum CxjDisplayingToastsCoordinator {
	static func updateLayoutFor(
		displayingToasts: [Toast],
		linkedToToast targetToast: Toast,
		withProgress progress: CGFloat,
		animation: Animation,
		completion: CxjBoolCompletion?
	) {
		
		let animatingAction: CxjVoidCompletion = {
            switch targetToast.config.coexistencePolicy.behaviour {
			case .stack(let attributes):
				let toastsToStack: [Toast] = linkedToastsToToast(
					targetToast,
					fromActiveToasts: displayingToasts,
					includingTargetToast: true
				)
                
                let stackDirection: CxjDisplayingToastsUpdater.StackDirection = switch attributes.direction {
                case .top: .top
                case .bottom: .bottom
                }
				
				CxjDisplayingToastsUpdater.stackLayoutToasts(
					toastsToStack: toastsToStack,
					progress: progress,
                    parameters: .init(
                        stackDirection: stackDirection,
                        maxVisibleToasts: attributes.maxVisibleToasts
                    )
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
		let isTopPositionToast: Bool = index == 0
		
		switch toast.config.coexistencePolicy.behaviour {
		case .stack(attributes: let attributes):
			if attributes.shouldStopTimerForStackedUnvisibleToasts {
				updateTimerStateForToast(toast, isTopPosition: isTopPositionToast)
			}
		case .hide(attributes: let attributes):
			if attributes.shouldStopTimerForHiddenToasts {
				updateTimerStateForToast(toast, isTopPosition: isTopPositionToast)
			}
		case .dismiss:
			break
		}
	}
	
	private static func updateTimerStateForToast(_ toast: Toast, isTopPosition: Bool) {
		let methods: Set<ToastDimissMethod> = [.time]
		isTopPosition
		? toast.dismisser.setupDimissMethods(methods, state: .active)
		: toast.dismisser.setupDimissMethods(methods, state: .paused)
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
				
				let attributesComparator: ToastAttributesComparator = ToastAttributesComparator(
                    lhsToast: activeToast,
                    rhsToast: targetToast,
					comparingAttributes: targetToast.config.coexistencePolicy.comparisonCriteria.attibutes
				)
				
				switch targetToast.config.coexistencePolicy.comparisonCriteria.logicOperation {
				case .or:
					return attributesComparator.isOneOfAttributesEqual()
				case .and:
					return attributesComparator.isAllAttributesEqual()
				}
			}
			.reversed()
	}
}

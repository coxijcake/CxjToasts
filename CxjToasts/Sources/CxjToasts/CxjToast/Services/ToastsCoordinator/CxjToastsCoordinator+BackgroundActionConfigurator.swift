//
//  CxjToastsCoordinator+BackgroundActionConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 15/12/2024.
//

import UIKit

extension CxjToastsCoordinator {
	@MainActor
	enum SourceBackgroundActionConfigurator {
		static func configureActionForToast(_ toast: any CxjDisplayableToast) {
			switch toast.config.sourceBackground?.interaction {
			case .disabled:
				toast.sourceBackgroundView?.isUserInteractionEnabled = false
			case .none:
				break
			case .enabled(action: let action):
				guard let action else { break }
				
				let actionHandling: CxjVoidCompletion? = {
					switch action.handling {
					case .none:
						return {}
					case .dismissToast:
						return { [ weak toast] in
							guard let toast else { return }
							
							Task { @MainActor in
								CxjToastsCoordinator.shared.dismissToast(toast, animated: true)
							}
						}
					case .custom(let completion):
						return { [weak toast] in
							guard let toast else { return }
							completion?(toast)
						}
					}
				}()
				
				toast.sourceBackgroundView?.addInteractionAction(actionHandling, forEvent: action.touchEvent)
			}
		}
	}
}

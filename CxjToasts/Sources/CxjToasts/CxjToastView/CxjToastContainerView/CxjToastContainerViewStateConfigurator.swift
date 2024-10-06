//
//  CxjToastContainerViewStateConfigurator.swift
//  
//
//  Created by Nikita Begletskiy on 06/10/2024.
//

import UIKit

enum CxjToastContainerViewStateConfigurator {
	typealias Config = CxjToastViewConfiguration
	typealias ViewState = CxjToastContainerView.ViewState
	
	static func state(for config: CxjToastViewConfiguration) -> ViewState {
		let shadow: ViewState.Shadow = stateShadowFor(config.shadow)
		let corners: ViewState.Corners = stateCornersFor(configCorners: config.corners)
		
		return ViewState(
			contentInsets: config.contentInsets,
			backgroundColor: config.colors.background,
			shadow: shadow,
			corners: corners
		)
	}
	
	private static func stateShadowFor(
		_ configShadow: Config.Shadow
	) -> ViewState.Shadow {
		switch configShadow {
		case .disable:
			return .disabled
		case .enable(params: let params):
			return .enabled(params: params)
		}
	}
	
	private static func stateCornersFor(configCorners: Config.Corners) -> ViewState.Corners {
		switch configCorners {
		case .straight(mask: let mask):
			return .init(type: .rounded(value: .zero), mask: mask.layerMask)
		case .capsule(mask: let mask):
			return .init(type: .capsule, mask: mask.layerMask)
		case .rounded(value: let value, mask: let mask):
			return .init(type: .rounded(value: value), mask: mask.layerMask)
		}
	}
}

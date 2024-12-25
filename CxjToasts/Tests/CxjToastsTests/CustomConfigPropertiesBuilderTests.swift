//
//  CustomConfigPropertiesBuilderTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 25/12/2024.
//

import UIKit
import Testing

@testable import CxjToasts

final class CustomConfigPropertiesBuilderTests {
	typealias Input = ConfigStrategyCommonInput
	typealias Change = ToastConfig.Animation.Behaviour.CustomBehaviourChange

	// MARK: - Mock Data
	let mockInput = Input(
		presentedStateAnimatingProperties: .init(
			alpha: ClampedAlpha(value: 1.0),
			scale: .init(x: 1.0, y: 1.0),
			translation: .init(x: 0, y: 0),
			cornerRadius: .init(value: 10, constraint: .none),
			shadowOverlay: .off
		),
		toastViewData: .init(
			size: .init(width: 100, height: 50),
			placement: .bottom(params: .init(offset: 10, includingSafeArea: true))
		),
		sourceViewData: .init(
			frame: .init(x: 0, y: 0, width: 200, height: 400),
			safeAreaInsets: .init(top: 10, left: 10, bottom: 10, right: 10)
		)
	)

	// MARK: - Tests
	@Test
	func testInitialization() throws {
		let builder = CustomConfigPropertiesBuilder(input: mockInput)
		
		#expect(builder.alpha.value == 1.0)
		#expect(builder.scale.x == 1.0)
		#expect(builder.scale.y == 1.0)
		#expect(builder.translation.x == 0)
		#expect(builder.translation.y == 0)
		#expect(builder.cornerRadius.value == 10)
		#expect(builder.shadowOverlay == .off)
	}

	@Test
	func testUpdateAlpha() throws {
		let builder = CustomConfigPropertiesBuilder(input: mockInput)
		builder.update(with: .alpha(intensity: 0.5))
		
		#expect(builder.alpha.value == 0.5)
	}

	@Test
	func testUpdateScale() throws {
		let builder = CustomConfigPropertiesBuilder(input: mockInput)
		builder.update(with: .scale(value: .init(x: 2.0, y: 2.0)))
		
		#expect(builder.scale.x == 2.0)
		#expect(builder.scale.y == 2.0)
	}

	@Test
	func testBuildResult() throws {
		let builder = CustomConfigPropertiesBuilder(input: mockInput)
		builder.update(with: .alpha(intensity: 0.7))
		builder.update(with: .scale(value: .init(x: 1.5, y: 1.5)))
		
		let result = builder.build()
		
		#expect(result.alpha.value == 0.7)
		#expect(result.scale.x == 1.5)
		#expect(result.scale.y == 1.5)
	}

	@Test
	func testOutOfSourceViewVerticalTranslation() throws {
		let builder = CustomConfigPropertiesBuilder(input: mockInput)
		
		let translation = builder.translationFor(translationType: .outOfSourceViewVerticaly)
		
		#expect(translation.x == 0)
		#expect(translation.y == (10 + 10 + 50)) // offset + safe area + height
	}

	@Test
	func testCornerRadiusValue() throws {
		let builder = CustomConfigPropertiesBuilder(input: mockInput)
		
		let cornerRadius = builder.cornerRadiusValue(for: .init(
			type: .custom(value: 20),
			constraint: .none
		))
		
		#expect(cornerRadius.value == 20)
		#expect(cornerRadius.constraint == .none)
	}
}

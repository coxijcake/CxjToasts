//
//  CustomConfigPropertiesBuilderTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 25/12/2024.
//

#if canImport(Testing)

import UIKit
import Testing

@testable import CxjToasts

@MainActor
final class ToastAnimatorCustomConfigPropertiesBuilderTests {
	typealias Builder = CxjToastAnimator.CustomConfigPropertiesBuilder
	typealias Animations = Builder.Animations
	typealias Input = Builder.Input
	typealias Change = Builder.Change
	
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
		let builder = Builder(input: mockInput)
		
		#expect(builder.alpha.value == mockInput.presentedStateAnimatingProperties.alpha.value)
		#expect(builder.scale.x == mockInput.presentedStateAnimatingProperties.scale.x)
		#expect(builder.scale.y == mockInput.presentedStateAnimatingProperties.scale.y)
		#expect(builder.translation.x == mockInput.presentedStateAnimatingProperties.translation.x)
		#expect(builder.translation.y == mockInput.presentedStateAnimatingProperties.translation.y)
		#expect(builder.cornerRadius.value == mockInput.presentedStateAnimatingProperties.cornerRadius.value)
		#expect(builder.shadowOverlay == mockInput.presentedStateAnimatingProperties.shadowOverlay)
	}
	
	@Test
	func testUpdateAlpha() throws {
		let builder = Builder(input: mockInput)
		builder.update(with: .alpha(intensity: 0.5))
		
		#expect(builder.alpha.value == 0.5)
	}
	
	@Test
	func testUpdateScale() throws {
		let builder = Builder(input: mockInput)
		builder.update(with: .scale(value: .init(x: 2.0, y: 2.0)))
		
		#expect(builder.scale.x == 2.0)
		#expect(builder.scale.y == 2.0)
	}
	
	@Test
	func testBuildResult() throws {
		let builder = Builder(input: mockInput)
		builder.update(with: .alpha(intensity: 0.7))
		builder.update(with: .scale(value: .init(x: 1.5, y: 1.5)))
		
		let result = builder.build()
		
		#expect(result.alpha.value == 0.7)
		#expect(result.scale.x == 1.5)
		#expect(result.scale.y == 1.5)
	}
	
	@Test
	func testOutOfSourceViewVerticalTranslation() throws {
		let builder = Builder(input: mockInput)
		builder.update(with: .translation(type: .outOfSourceViewVerticaly))
		
		let translation = builder.translation
		
		#expect(translation.x == 0)
		#expect(translation.y == (10.0 + 10.0 + 50.0)) // offset + safe area + height
	}
	
	@Test
	func testOutOfSourceViewHorizontalTranslation() throws {
		let builder = Builder(input: mockInput)

		builder.update(with: .translation(type: .outOfSourceViewHorizontaly(direction: .left)))
		let leftTranslation = builder.translation

		let leftExpectedTranslationX = -(mockInput.toastViewData.size.width + 10.0 + (mockInput.sourceViewData.frame.width - mockInput.toastViewData.size.width) / 2) // toast width + safe area left + side offset
		#expect(leftTranslation.x == leftExpectedTranslationX)
		#expect(leftTranslation.y == 0)

		builder.update(with: .translation(type: .outOfSourceViewHorizontaly(direction: .right)))
		let rightTranslation = builder.translation

		let rightExpectedTranslationX = mockInput.toastViewData.size.width + 10.0 + (mockInput.sourceViewData.frame.width - mockInput.toastViewData.size.width) / 2 // toast width + safe area right + side offset
		#expect(rightTranslation.x == rightExpectedTranslationX)
		#expect(rightTranslation.y == 0)
	}
	
	@Test
	func testCornerRadiusValue() throws {
		let builder = Builder(input: mockInput)
		builder.update(with: .corners(radius: .init(type: .custom(value: 20), constraint: .none)))
		
		let cornerRadius = builder.cornerRadius
		
		#expect(cornerRadius.value == 20)
		#expect(cornerRadius.constraint == .none)
	}
}

#endif

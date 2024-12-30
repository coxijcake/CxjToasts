//
//  SourceBackgroundLayoutCalculatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 23/12/2024.
//

import UIKit
import Testing
@testable import CxjToasts

final class SourceBackgroundLayoutCalculatorTests {
    //MARK: - Types
    private typealias SourceBackgroundAnimatingProperties = CxjToastAnimator.SourceBackgroundAnimatingProperties
    
    //MARK: - Props
    private let presentedStateProps = SourceBackgroundAnimatingProperties(alpha: .init(value: 1.0))
    private let dismissedStateProps = SourceBackgroundAnimatingProperties(alpha: .init(value: 0.0))

    //MARK: - Tests
    @Test
    func testPropertiesForFullProgress() throws {
        let calculator = CxjToastAnimator.SourceBackgroundLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps
        )

        let progress = ToastLayoutProgress(value: 1.0) // Fully dismissed
        let result = calculator.propertiesFor(progress: progress)

        #expect(result.alpha.value == dismissedStateProps.alpha.value)
    }

    @Test
    func testPropertiesForZeroProgress() throws {
        let calculator = CxjToastAnimator.SourceBackgroundLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps
        )

        let progress = ToastLayoutProgress(value: 0.0) // Fully presented
        let result = calculator.propertiesFor(progress: progress)

        #expect(result.alpha.value == presentedStateProps.alpha.value)
    }

    @Test
    func testPropertiesForHalfwayProgress() throws {
        let calculator = CxjToastAnimator.SourceBackgroundLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps
        )

        let progress = ToastLayoutProgress(value: 0.5) // Halfway
        let result = calculator.propertiesFor(progress: progress)

        let expectedAlpha = (dismissedStateProps.alpha.value * 0.5) + (presentedStateProps.alpha.value * 0.5)
        
        #expect(result.alpha.value == expectedAlpha)
    }
    
    @Test
    func testAlphaValueCalculation() throws {
        let presentedStateProps = SourceBackgroundAnimatingProperties(alpha: .init(value: 1.0))
        let dismissedStateProps = SourceBackgroundAnimatingProperties(alpha: .init(value: 0.0))
        let calculator = CxjToastAnimator.SourceBackgroundLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps
        )

        let progress = ToastLayoutProgress(value: 0.75) // 75% dismissed
        let resultProperties = calculator.propertiesFor(progress: progress)

        let expectedAlpha = (dismissedStateProps.alpha.value * 0.75) + (presentedStateProps.alpha.value * 0.25)
        
        #expect(resultProperties.alpha.value == expectedAlpha)
    }

    @Test
    func testAlphaValueWithCustomStates() throws {
        let customPresentedState = SourceBackgroundAnimatingProperties(alpha: .init(value: 0.3))
        let customDismissedState = SourceBackgroundAnimatingProperties(alpha: .init(value: 0.9))
        let calculator = CxjToastAnimator.SourceBackgroundLayoutCalculator(
            presentedStateProps: customPresentedState,
            dismissedStateProps: customDismissedState
        )

        let progress = ToastLayoutProgress(value: 0.6) // 60% dismissed
        let resultProperties = calculator.propertiesFor(progress: progress)

        let expectedAlpha = (customDismissedState.alpha.value * 0.6) + (customPresentedState.alpha.value * 0.4)
        
        #expect(resultProperties.alpha.value == expectedAlpha)
    }
}

//
//  ToastLayoutCalculatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 23/12/2024.
//

import UIKit
import Testing
@testable import CxjToasts

final class ToastLayoutCalculatorTests {
    //MARK: - Types
    private typealias ToastAnimatingProperties = CxjToastAnimator.ToastAnimatingProperties
    
    //MARK: - Props
    private let toastSize = CGSize(width: 100, height: 200)

    private let presentedStateProps = ToastAnimatingProperties(
        alpha: .init(value: 1.0),
        scale: .init(x: 1.0, y: 1.0),
        translation: .init(x: 0.0, y: 0.0),
        cornerRadius: .init(value: 0.0, constraint: .none),
        shadowOverlay: .on(color: .black, alpha: .init(value: 1.0))
    )

    private let dismissedStateProps = ToastAnimatingProperties(
        alpha: .init(value: 0.0),
        scale: .init(x: 0.8, y: 0.8),
        translation: .init(x: 50.0, y: 100.0),
        cornerRadius: .init(value: 20.0, constraint: .none),
        shadowOverlay: .off
    )

    // MARK: - Tests
    @Test
    func testPropertiesForFullProgress() throws {
        let calculator = CxjToastAnimator.ToastLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps,
            toastSize: toastSize,
            cornerRadiusProgressSmoothing: nil
        )

        let progressValue: CGFloat = 1.0
        let progress = ToastLayoutProgress(value: progressValue) // Fully dismissed
        let result = calculator.propertiesFor(progress: progress)

        let expectedAlpha = (dismissedStateProps.alpha.value * progressValue) + (presentedStateProps.alpha.value * progress.revertedValue)
        let expectedScaleX = (dismissedStateProps.scale.x * progressValue) + (presentedStateProps.scale.x * progress.revertedValue)
        let expectedScaleY = (dismissedStateProps.scale.y * progressValue) + (presentedStateProps.scale.y * progress.revertedValue)

        let toastScaledWidthDifference = (toastSize.width - (toastSize.width * expectedScaleX)) / 2
        let expectedTranslationX = (dismissedStateProps.translation.x * progressValue) - toastScaledWidthDifference

        let toastScaledHeightDifference = (toastSize.height - (toastSize.height * expectedScaleY)) / 2
        let expectedTranslationY = (dismissedStateProps.translation.y * progressValue) - toastScaledHeightDifference

        let calculatedCornerRadius = (dismissedStateProps.cornerRadius.value * progressValue) + (presentedStateProps.cornerRadius.value * progress.revertedValue)
        let expectedCornerRadius: CGFloat = {
            switch dismissedStateProps.cornerRadius.constraint {
            case .none:
                return calculatedCornerRadius
            case .halfHeight:
                let maxCornerRadius = toastSize.height * 0.5
                return min(maxCornerRadius, calculatedCornerRadius)
            }
        }()

        #expect(result.alpha.value == expectedAlpha)
        #expect(result.scale.x == expectedScaleX)
        #expect(result.scale.y == expectedScaleY)
        #expect(result.translation.x == expectedTranslationX)
        #expect(result.translation.y == expectedTranslationY)
        #expect(result.cornerRadius.value == expectedCornerRadius)
        #expect(result.shadowOverlay == dismissedStateProps.shadowOverlay)
    }

    @Test
    func testPropertiesForZeroProgress() throws {
        let calculator = CxjToastAnimator.ToastLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps,
            toastSize: toastSize,
            cornerRadiusProgressSmoothing: nil
        )

        let progress = ToastLayoutProgress(value: 0.0) // Fully presented
        let result = calculator.propertiesFor(progress: progress)
        
        #expect(result.alpha.value == presentedStateProps.alpha.value)
        
        #expect(result.scale.x == presentedStateProps.scale.x)
        #expect(result.scale.y == presentedStateProps.scale.y)
        
        #expect(result.translation.x == presentedStateProps.translation.x)
        #expect(result.translation.y == presentedStateProps.translation.y)
        
        #expect(result.cornerRadius.value == presentedStateProps.cornerRadius.value)

        switch dismissedStateProps.shadowOverlay {
        case .off:
            #expect(result.shadowOverlay == .off)
        case .on(let color, let dismissedAlpha):
            switch presentedStateProps.shadowOverlay {
            case .on(color: _, alpha: let presentedAlpha):
                let expectedAlpha = (dismissedAlpha.value * progress.value) + (presentedAlpha.value * progress.revertedValue)
                #expect(result.shadowOverlay == .on(color: color, alpha: .init(value: expectedAlpha)))
            case .off:
                #expect(result.shadowOverlay == .off)
            }
        }
    }

    @Test
    func testPropertiesForHalfwayProgress() throws {
        let calculator = CxjToastAnimator.ToastLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps,
            toastSize: toastSize,
            cornerRadiusProgressSmoothing: nil
        )

        let progressValue: CGFloat = 0.5
        let progress = ToastLayoutProgress(value: progressValue) // Halfway
        let result = calculator.propertiesFor(progress: progress)

        let expectedAlpha = (dismissedStateProps.alpha.value * progressValue) + (presentedStateProps.alpha.value * progressValue)
        let expectedScaleX = (dismissedStateProps.scale.x * progressValue) + (presentedStateProps.scale.x * progressValue)
        let expectedScaleY = (dismissedStateProps.scale.y * progressValue) + (presentedStateProps.scale.y * progressValue)

        let toastScaledWidthDifference = (toastSize.width - (toastSize.width * expectedScaleX)) / 2
        let expectedTranslationX = (dismissedStateProps.translation.x * progressValue) - toastScaledWidthDifference

        let toastScaledHeightDifference = (toastSize.height - (toastSize.height * expectedScaleY)) / 2
        let expectedTranslationY = (dismissedStateProps.translation.y * progressValue) - toastScaledHeightDifference

        let calculatedCornerRadius = (dismissedStateProps.cornerRadius.value * progressValue) + (presentedStateProps.cornerRadius.value * progressValue)
        let expectedCornerRadius: CGFloat = {
            switch dismissedStateProps.cornerRadius.constraint {
            case .none:
                return calculatedCornerRadius
            case .halfHeight:
                let maxCornerRadius = toastSize.height * 0.5
                return min(maxCornerRadius, calculatedCornerRadius)
            }
        }()

        #expect(result.alpha.value == expectedAlpha)
        #expect(result.scale.x == expectedScaleX)
        #expect(result.scale.y == expectedScaleY)
        #expect(result.translation.x == expectedTranslationX)
        #expect(result.translation.y == expectedTranslationY)
        #expect(result.cornerRadius.value == expectedCornerRadius)
    }

    @Test
    func testPropertiesForShadowOverlayOff() throws {
        let calculator = CxjToastAnimator.ToastLayoutCalculator(
            presentedStateProps: presentedStateProps,
            dismissedStateProps: dismissedStateProps,
            toastSize: toastSize,
            cornerRadiusProgressSmoothing: nil
        )

        let progress = ToastLayoutProgress(value: 1.0) // Fully dismissed
        let result = calculator.propertiesFor(progress: progress)

        #expect(result.shadowOverlay == .off)
    }

    @Test
    func testPropertiesForShadowOverlayTransition() throws {
        let customPresentedState = ToastAnimatingProperties(
            alpha: .init(value: 1.0),
            scale: .init(x: 1.0, y: 1.0),
            translation: .init(x: 0.0, y: 0.0),
            cornerRadius: .init(value: 0.0, constraint: .none),
            shadowOverlay: .on(color: .black, alpha: .init(value: 1.0))
        )

        let customDismissedState = ToastAnimatingProperties(
            alpha: .init(value: 0.0),
            scale: .init(x: 0.8, y: 0.8),
            translation: .init(x: 50.0, y: 100.0),
            cornerRadius: .init(value: 20.0, constraint: .none),
            shadowOverlay: .on(color: .black, alpha: .init(value: 0.5))
        )

        let calculator = CxjToastAnimator.ToastLayoutCalculator(
            presentedStateProps: customPresentedState,
            dismissedStateProps: customDismissedState,
            toastSize: toastSize,
            cornerRadiusProgressSmoothing: nil
        )

        let progress = ToastLayoutProgress(value: 0.5) // Halfway
        let result = calculator.propertiesFor(progress: progress)
        
        switch result.shadowOverlay {
        case .off:
            break
        case .on(color: _, alpha: let alpha):
            let expectedShadowAlpha = (alpha.value * 0.5) + (alpha.value * 0.5)
            #expect(alpha.value == expectedShadowAlpha)
        }
    }
}

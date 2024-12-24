//
//  ToastLayoutProgressTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import Foundation
import Testing

@testable import CxjToasts

final class ToastLayoutProgressTests {
    //MARK: - Tests
    @Test
    func testClampingMinValue() throws {
        let progress = ToastLayoutProgress(value: -0.5)
        #expect(progress.value == 0.0)
    }
    
    @Test
    func testClampingMaxValue() throws {
        let progress = ToastLayoutProgress(value: 1.5)
        #expect(progress.value == 1.0)
    }

    @Test
    func testRevertedValue() throws {
        let progress = ToastLayoutProgress(value: 0.25)
        #expect(progress.revertedValue == 0.75)
    }
    
    @Test
    func testRevertedValueAtMax() throws {
        let progress = ToastLayoutProgress(value: 1.0)
        #expect(progress.revertedValue == 0.0)
    }
    
    @Test
    func testSmoothedProgressBelowThreshold() throws {
        let progress = ToastLayoutProgress(value: 0.25)
        let smoothedProgress = progress.smoothed(threshold: 0.5)
        
        let expectedSmoothedValue = SmoothProgressCalculator(
            originalProgress: 0.25,
            threshold: 0.5
        ).smoothedProgress()
        
        #expect(smoothedProgress.value == CGFloat(expectedSmoothedValue))
    }

    @Test
    func testSmoothedProgressAboveThreshold() throws {
        let progress = ToastLayoutProgress(value: 0.75)
        let smoothedProgress = progress.smoothed(threshold: 0.5)
        
        let expectedSmoothedValue = SmoothProgressCalculator(
            originalProgress: 0.75,
            threshold: 0.5
        ).smoothedProgress()
        
        #expect(smoothedProgress.value == CGFloat(expectedSmoothedValue))
    }
}

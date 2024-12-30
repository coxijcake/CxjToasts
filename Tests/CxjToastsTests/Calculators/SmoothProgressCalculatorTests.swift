//
//  SmoothProgressCalculatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import Testing
@testable import CxjToasts

final class SmoothProgressCalculatorTests {
    //MARK: - Tests
    
    @Test
    func testSmoothedProgressAtMinimumOriginalProgress() throws {
        let calculator = SmoothProgressCalculator(originalProgress: 0.0, threshold: 0.5)
        let result = calculator.smoothedProgress()
        
        #expect(result == 0.0)
    }

    @Test
    func testSmoothedProgressAtMaximumOriginalProgress() throws {
        let calculator = SmoothProgressCalculator(originalProgress: 1.0, threshold: 0.5)
        let result = calculator.smoothedProgress()
        
        #expect(result == 1.0)
    }

    @Test
    func testSmoothedProgressAtThreshold() throws {
        let calculator = SmoothProgressCalculator(originalProgress: 0.5, threshold: 0.5)
        let result = calculator.smoothedProgress()
        
        #expect(result == 0.25)
    }

    @Test
    func testSmoothedProgressBelowThreshold() throws {
        let calculator = SmoothProgressCalculator(originalProgress: 0.25, threshold: 0.5)
        let result = calculator.smoothedProgress()
        let expected = (0.25 / 0.5) * (0.5 / 2)
        
        #expect(result == Float(expected))
    }

    @Test
    func testSmoothedProgressAboveThreshold() throws {
        let calculator = SmoothProgressCalculator(originalProgress: 0.75, threshold: 0.5)
        let result = calculator.smoothedProgress()
        let expected = (0.75 - 0.5)
            / (1 - 0.5)
            * (1 - 0.5 / 2)
            + (0.5 / 2)
        
        #expect(result == Float(expected))
    }

    @Test
    func testSmoothedProgressWithZeroThreshold() throws {
        let calculator = SmoothProgressCalculator(originalProgress: 0.525, threshold: 0.0)
        let result = calculator.smoothedProgress()
        
        #expect(result == 0.525)
    }

    @Test
    func testSmoothedProgressWithFullThreshold() throws {
        let calculator = SmoothProgressCalculator(originalProgress: 0.5, threshold: 1.0)
        let result = calculator.smoothedProgress()
        let expected = (0.5 / 1.0) * (1.0 / 2)
        
        #expect(result == Float(expected))
    }
}

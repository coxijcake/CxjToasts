//
//  ToastLayoutProgressTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

#if canImport(Testing)

import Foundation
import Testing

import XCTest
@testable import CxjToasts

final class ToastLayoutProgressTests: XCTestCase {
	
	func testClampingMinValue() {
		let progress = ToastLayoutProgress(value: -0.5)
		
		XCTAssertEqual(
			progress.value,
			0.0,
			"Value should be clamped to 0.0 when below the minimum threshold"
		)
	}
	
	func testClampingMaxValue() {
		let progress = ToastLayoutProgress(value: 1.5)
		
		XCTAssertEqual(
			progress.value,
			1.0,
			"Value should be clamped to 1.0 when above the maximum threshold"
		)
	}

	func testRevertedValue() {
		let progress = ToastLayoutProgress(value: 0.25)
		
		XCTAssertEqual(
			progress.revertedValue,
			0.75,
			"Reverted value should be calculated correctly"
		)
	}
	
	func testRevertedValueAtMax() {
		let progress = ToastLayoutProgress(value: 1.0)
		
		XCTAssertEqual(
			progress.revertedValue,
			0.0,
			"Reverted value should be 0.0 when progress is at max"
		)
	}
	
	func testSmoothedProgressBelowThreshold() {
		let progress = ToastLayoutProgress(value: 0.25)
		let smoothedProgress = progress.smoothed(threshold: 0.5)
		
		let expectedSmoothedValue = SmoothProgressCalculator(
			originalProgress: 0.25,
			threshold: 0.5
		).smoothedProgress()
		
		XCTAssertEqual(
			smoothedProgress.value,
			CGFloat(expectedSmoothedValue),
			accuracy: 0.001,
			"Smoothed progress should match the expected value below the threshold"
		)
	}

	func testSmoothedProgressAboveThreshold() {
		let progress = ToastLayoutProgress(value: 0.75)
		let smoothedProgress = progress.smoothed(threshold: 0.5)
		
		let expectedSmoothedValue = SmoothProgressCalculator(
			originalProgress: 0.75,
			threshold: 0.5
		).smoothedProgress()
		
		XCTAssertEqual(
			smoothedProgress.value,
			CGFloat(expectedSmoothedValue),
			accuracy: 0.001,
			"Smoothed progress should match the expected value above the threshold"
		)
	}
}


#endif

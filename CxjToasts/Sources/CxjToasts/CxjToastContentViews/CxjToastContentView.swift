//
//  CxjToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

/// A required protocol for any custom view used as toast content.
///
/// This protocol must be adopted to use a custom view as the content of a toast.
/// The methods are optional to implement and are only used if the content view needs
/// to display feedback about the remaining timer or dismissal progress.
public protocol CxjToastContentView: UIView {
	
	/// Updates the content view based on the remaining display time of the toast.
	///
	/// - Parameters:
	///   - time: The remaining time (in seconds) before the toast is dismissed.
	///   - animated: Indicates whether the update should be animated.
	///
	/// - Note: Implement this method if the content view needs to provide feedback
	///   about the remaining display time, such as a countdown or timer.
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool)
	
	/// Updates the content view based on the current dismissal progress of the toast.
	///
	/// - Parameters:
	///   - progress: A value between `0.0` (fully presented) and `1.0` (fully dismissed) indicating the dismissal progress.
	///   - animated: Indicates whether the update should be animated.
	///
	/// - Note: Implement this method if the content view needs to respond to the
	///   progress of the toast being dismissed, such as updating a visual effect.
	func updateForDismissingProgress(_ progress: Float, animated: Bool)
}

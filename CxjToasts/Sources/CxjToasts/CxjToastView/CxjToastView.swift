//
//  CxjToastView.swift
//  
//
//  Created by Nikita Begletskiy on 18/08/2024.
//

import UIKit

public protocol CxjToastView: UIView {
    typealias Configuration = CxjToastViewConfiguration
    
	/// Prepares the toast view for display.
	///
	/// This method is called after the layout of the toast view has been calculated and finalized.
	/// It can be used to perform additional setup, animations, or adjustments before the toast is shown to the user.
	///
	/// Typical use cases include:
	/// - Applying final visual adjustments (e.g., shadows, borders, rounded corners).
	/// - Triggering animations or transitions to make the toast appear smoothly.
	/// - Preparing dynamic content based on the calculated layout.
	///
	/// **Note:** Ensure that this method is called only after the layout is fully calculated.
    func prepareToDisplay()
	
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool)
	func updateForDismissingProgress(_ progress: Float, animated: Bool)
}

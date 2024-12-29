//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

/// Identifier for the toast, used to manage interactions such as spam protection
/// and coexistence policies. This `typeId` can also be used to close all toasts
/// with the same identifier.
///
/// - Note: `typeId` is not required to be unique and is distinct from `CxjToast.id`.
public typealias CxjToastTypeid = String

/// Configuration structure for a toast, defining its appearance, behavior, and interaction logic.
public struct CxjToastConfiguration: Sendable {
	public let typeId: CxjToastTypeid
	
	/// The view associated with the toast. Often used for layout calculations or interactions.
	public let sourceView: UIView
	
	/// Optional background configuration for the toast, supporting touch interactions and actions.
	public let sourceBackground: SourceBackground?
	
	/// Layout configuration for the toast, including `placement` and `constraints`.
	public let layout: Layout
	
	/// Defines how the toast can be dismissed, such as by swipe, tap, or automatic timeout.
	public let dismissMethods: Set<DismissMethod>
	
	/// Configures behavior when a keyboard is visible, such as moving the toast above it.
	public let keyboardHandling: KeyboardHandling
	
	/// Animation settings for toast presentation and dismissal.
	public let animations: Animations
	
	/// Optional haptic feedback for the toast, such as success, error, or custom.
	public let hapticFeeback: CxjHapticFeedback?
	
	/// Enables or disables spam protection and defines criteria for toast comparison.
	public let spamProtection: SpamProtection
	
	/// Defines how the toast interacts with others when a new toast is displayed.
	public let coexistencePolicy: ToastCoexistencePolicy
	
	/// Initializes the configuration structure with the provided parameters.
	///
	/// - Parameters:
	///   - typeId: Identifier for the toast.
	///   - sourceView: The view associated with the toast.
	///   - sourceBackground: Optional background configuration.
	///   - layout: Layout configuration for the toast.
	///   - dismissMethods: Defines how the toast can be dismissed.
	///   - keyboardHandling: Behavior when a keyboard is visible.
	///   - animations: Animation settings for presentation and dismissal.
	///   - hapticFeeback: Optional haptic feedback.
	///   - spamProtection: Spam protection configuration.
	///   - coexistencePolicy: Coexistence policy for managing multiple toasts.
	public init(
		typeId: CxjToastTypeid,
		sourceView: UIView,
		sourceBackground: SourceBackground?,
		layout: Layout,
		dismissMethods: Set<DismissMethod>,
		keyboardHandling: KeyboardHandling,
		animations: Animations,
		hapticFeeback: CxjHapticFeedback?,
		spamProtection: SpamProtection,
		coexistencePolicy: ToastCoexistencePolicy
	) {
		self.typeId = typeId
		self.sourceView = sourceView
		self.sourceBackground = sourceBackground
		self.layout = layout
		self.dismissMethods = dismissMethods
		self.keyboardHandling = keyboardHandling
		self.animations = animations
		self.hapticFeeback = hapticFeeback
		self.spamProtection = spamProtection
		self.coexistencePolicy = coexistencePolicy
	}
}

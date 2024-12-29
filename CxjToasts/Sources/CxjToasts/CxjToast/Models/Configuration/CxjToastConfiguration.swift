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

//MARK: - Configuration
public struct CxjToastConfiguration: Sendable {
	public let typeId: CxjToastTypeid
	public let sourceView: UIView
	public let sourceBackground: SourceBackground?
    public let layout: Layout
    public let dismissMethods: Set<DismissMethod>
	public let keyboardHandling: KeyboardHandling
	public let animations: Animations
    public let hapticFeeback: CxjHapticFeedback?
	public let spamProtection: SpamProtection
	public let coexistencePolicy: ToastCoexistencePolicy
    
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

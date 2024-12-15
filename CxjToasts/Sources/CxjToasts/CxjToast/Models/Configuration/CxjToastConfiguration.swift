//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Configuration
public struct CxjToastConfiguration: Sendable {
	public let typeId: String
	public let sourceView: UIView
	public let sourceBackground: SourceBackground?
    public let layout: Layout
    public let dismissMethods: Set<DismissMethod>
	public let keyboardHandling: KeyboardHandling
	public let animations: Animations
	public let spamProtection: SpamProtection
	public let displayingBehaviour: DisplayingBehaviour
    
    public init(
		typeId: String,
		sourceView: UIView,
		sourceBackground: SourceBackground?,
        layout: Layout,
        dismissMethods: Set<DismissMethod>,
		keyboardHandling: KeyboardHandling,
		animations: Animations,
		spamProtection: SpamProtection,
		displayingSameAttributeToastBehaviour: DisplayingBehaviour
    ) {
		self.typeId = typeId
		self.sourceView = sourceView
		self.sourceBackground = sourceBackground
        self.layout = layout
        self.dismissMethods = dismissMethods
		self.keyboardHandling = keyboardHandling
        self.animations = animations
		self.spamProtection = spamProtection
		self.displayingBehaviour = displayingSameAttributeToastBehaviour
    }
}

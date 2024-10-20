//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Configuration
public struct CxjToastConfiguration {
	public let typeId: String?
	public let sourceView: UIView
    public let layout: Layout
    public let dismissMethods: Set<DismissMethod>
	public let animations: Animations
    
    public init(
		typeId: String?,
		sourceView: UIView,
        layout: Layout,
        dismissMethods: Set<DismissMethod>,
		animations: Animations
    ) {
		self.typeId = typeId
		self.sourceView = sourceView
        self.layout = layout
        self.dismissMethods = dismissMethods
        self.animations = animations
    }
}

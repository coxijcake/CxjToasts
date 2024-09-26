//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Configuration
public struct CxjToastConfiguration {
	let sourceView: UIView
    let layout: Layout
    let dismissMethods: Set<DismissMethod>
	let animations: Animations
    
    public init(
		sourceView: UIView,
        layout: Layout,
        dismissMethods: Set<DismissMethod>,
		animations: Animations
    ) {
		self.sourceView = sourceView
        self.layout = layout
        self.dismissMethods = dismissMethods
        self.animations = animations
    }
}

//
//  CxjToastTheme.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

//MARK: - Types
extension CxjToastTheme {
	public typealias ViewConfig = CxjToastViewConfiguration
	typealias ViewConfigurator = CxjToastViewConfigurator
	
	public typealias ToastConfig = CxjToastConfiguration
}

public enum CxjToastTheme {
	case native
}

//MARK: - ToastViewConfiguration
extension CxjToastTheme {
	public var toastViewConfig: ViewConfig {
		ViewConfigurator.config(for: self)
	}
	
	public var viewContentInsets: UIEdgeInsets {
		ViewConfigurator.contentInsets(for: self)
	}
	
	public var viewColors: ViewConfig.Colors {
		ViewConfigurator.colors(for: self)
	}
	
	public var viewShadow: ViewConfig.Shadow {
		ViewConfigurator.shadow(for: self)
	}
	
	public var viewCornerRadius: CGFloat {
		ViewConfigurator.cornerRadius(for: self)
	}
}

//MARK: - ToastConfig
extension CxjToastTheme {
	public var toastConfig: ToastConfig {
        CxjToastConfigurator.config(for: self)
	}
	
	public var sourceView: UIView {
        CxjToastConfigurator.sourceView(for: self)
	}
	
	public var layout: ToastConfig.Layout {
        CxjToastConfigurator.layout(for: self)
	}
    
    public var constraints: ToastConfig.Constraints {
        CxjToastConfigurator.constraints(for: self)
    }
	
	public var widthConstraint: ToastConfig.Constraints.Values {
        CxjToastConfigurator.widthConstraint(for: self)
	}
	
	public var heightConstraint: ToastConfig.Constraints.Values {
        CxjToastConfigurator.heightConstraint(for: self)
	}
	
	public var placement: ToastConfig.Layout.Placement {
        CxjToastConfigurator.placement(for: self)
	}
	
	public var dismissMethods: Set<ToastConfig.DismissMethod> {
        CxjToastConfigurator.dismissMethods(for: self)
	}
	
	public var animations: ToastConfig.Animations {
        CxjToastConfigurator.animations(for: self)
	}
	
	public var presentAnimation: CxjAnimation {
        CxjToastConfigurator.presentAnimation(for: self)
	}
	
	public var dismissAnimation: CxjAnimation {
        CxjToastConfigurator.dismissAnimation(for: self)
	}
}

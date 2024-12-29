//
//  CxjToastTemplate+ActionableEventToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 16/12/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct ActionableEventToastData {
		public typealias Title = CxjLabelConfiguration
		public typealias Icon = CxjIconConfiguration
		public typealias Constraints = CxjToastConfiguration.Constraints
		public typealias DefaultControlConfig = CxjActionToastContentConfiguration.ActionControl.TitleConfig
		
		public enum ActionControlType {
			case custom(control: UIControl)
			case `default`(config: DefaultControlConfig)
		}
		
		public struct ActionControl {
			public typealias ActionCompletion = (_ toastId: UUID) -> Void
			
			public let actionCompletion: ActionCompletion?
			public let type: ActionControlType
			
			public init(actionCompletion: ActionCompletion?, type: ActionControlType) {
				self.actionCompletion = actionCompletion
				self.type = type
			}
		}
		
		public struct Toast {
			public let placement: CxjToastConfiguration.Layout.Placement
			public let dismissMethods: Set<CxjToastConfiguration.DismissMethod>
			public let animations: CxjToastConfiguration.Animations
			public let spamProtection: CxjToastConfiguration.SpamProtection
			public let coexistencePolicy: CxjToastConfiguration.ToastCoexistencePolicy
			
			public init(
				placement: CxjToastConfiguration.Layout.Placement,
				dismissMethods: Set<CxjToastConfiguration.DismissMethod>,
				animations: CxjToastConfiguration.Animations,
				spamProtection: CxjToastConfiguration.SpamProtection,
                coexistencePolicy: CxjToastConfiguration.ToastCoexistencePolicy
			) {
				self.placement = placement
				self.dismissMethods = dismissMethods
				self.animations = animations
				self.spamProtection = spamProtection
				self.coexistencePolicy = coexistencePolicy
			}
		}
		
		public struct ToastView {
			public let background: CxjToastViewConfiguration.Background
			public let shadow: CxjToastViewConfiguration.Shadow
			public let corners: CxjToastViewConfiguration.Corners
			
			public init(
				background: CxjToastViewConfiguration.Background,
				shadow: CxjToastViewConfiguration.Shadow,
				corners: CxjToastViewConfiguration.Corners
			) {
				self.background = background
				self.shadow = shadow
				self.corners = corners
			}
		}
		
		public struct Content {
			public let title: Title
			public let icon: Icon?
			
			public init(title: Title, icon: Icon?) {
				self.title = title
				self.icon = icon
			}
		}
		
		public let typeId: CxjToastTypeid
		public let customSourceView: UIView?
		public let actionControl: ActionControl
		public let content: Content
		public let toast: Toast
		public let toastView: ToastView
		public let hapticFeeback: CxjHapticFeedback?

		public init(
			typeId: CxjToastTypeid,
			customSourceView: UIView?,
			actionControl: ActionControl,
			content: Content,
			toast: Toast,
			toastView: ToastView,
			hapticFeeback: CxjHapticFeedback?
		) {
			self.typeId = typeId
			self.customSourceView = customSourceView
			self.actionControl = actionControl
			self.content = content
			self.toast = toast
			self.toastView = toastView
			self.hapticFeeback = hapticFeeback
		}
	}
}

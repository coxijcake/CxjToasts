//
//  CxjToastTemplate+UndoAction.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 12/11/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct UndoActionToastData {
		public typealias TimingFeedback = CxjUndoActionToastContentConfiguration.TimingFeedback
		public typealias Text = CxjTextConfiguration
		public typealias DefaultUndoControlTitleConfig = CxjUndoActionToastContentConfiguration.UndoControl.TitleConfig
		
		public enum UndoControlType {
			case custom(control: UIControl)
			case `default`(config: DefaultUndoControlTitleConfig)
		}
		
		public struct UndoControl {
			public typealias ActionCompletion = (_ toastId: UUID) -> Void
			
			public let actionCompletion: ActionCompletion?
			public let type: UndoControlType
			
			public init(
				actionCompletion: ActionCompletion?,
				type: UndoControlType
			) {
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
		
		public let typeId: String
		public let customSourceView: UIView?
		public let title: Text
		public let subtitle: Text?
		public let timingFeedback: TimingFeedback
		public let undoControl: UndoControl
		public let toast: Toast
		public let toastView: ToastView
		
		
		public init(
			typeId: String,
			customSourceView: UIView?,
			title: Text,
			subtitle: Text?,
			timingFeedback: TimingFeedback,
			undoControl: UndoControl,
			toast: Toast,
			toastView: ToastView
		) {
			self.typeId = typeId
			self.customSourceView = customSourceView
			self.title = title
			self.subtitle = subtitle
			self.timingFeedback = timingFeedback
			self.undoControl = undoControl
			self.toast = toast
			self.toastView = toastView
		}
	}
}

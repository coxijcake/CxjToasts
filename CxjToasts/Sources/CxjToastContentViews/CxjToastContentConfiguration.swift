//
//  CxjToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

/// Configuration options for the content displayed in a toast.
public enum CxjToastContentConfiguration {
	/// Displays informational content in the toast.
	/// - Parameter type: The type of informational content to display.
	case info(type: InfoContentType)
	
	/// Displays a toast with an actionable button and additional informational content.
	/// - Parameters:
	///   - config: Configuration for the action button.
	///   - infoContent: Informational content displayed alongside the action.
	case action(config: CxjActionToastContentConfiguration, infoContent: InfoContentType)
	
	/// Displays a toast with an undo action button.
	/// - Parameter config: Configuration for the undo action.
	case undoAction(config: CxjUndoActionToastContentConfiguration)
	
	/// Displays a custom content view in the toast.
	/// - Parameter contentView: A custom view implementing `CxjToastContentView`.
	case custom(contentView: CxjToastContentView)
}

// MARK: - Nested types
extension CxjToastContentConfiguration {
	/// Types of informational content that can be displayed in a toast.
	public enum InfoContentType {
		/// Displays text-only content in the toast.
		/// - Parameter config: Configuration for the text content.
		case text(config: CxjToastTextContentConfiguration)
		
		/// Displays text with an accompanying icon in the toast.
		/// - Parameters:
		///   - iconConfig: Configuration for the icon.
		///   - textConfig: Configuration for the text content.
		case textWithIcon(iconConfig: CxjIconedToastContentConfiguration, textConfig: CxjToastTextContentConfiguration)
	}
}

//
//  CxjToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

public enum CxjToastContentConfiguration {
	case info(type: InfoContentType)
	case action(config: CxjActionToastContentConfiguration, infoContent: InfoContentType)
	case undoAction(config: CxjUndoActionToastContentConfiguration)
	case custom(contentView: CxjToastContentView)
}

//MARK: - Nested types
extension CxjToastContentConfiguration {
	public enum InfoContentType {
		case text(config: CxjToastTextContentConfiguration)
		case textWithIcon(iconConfig: CxjIconedToastContentConfiguration, textConfig: CxjToastTextContentConfiguration)
	}
}

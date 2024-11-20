//
//  CxjToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

public enum CxjToastContentConfiguration {
    case iconed(config: CxjIconedToastContentConfiguration, titlesConfig: CxjTitledToastContentConfiguration)
    case titled(config: CxjTitledToastContentConfiguration)
	case undoAction(config: CxjUndoActionToastContentConfiguration)
    case custom(contentView: CxjToastContentView)
}

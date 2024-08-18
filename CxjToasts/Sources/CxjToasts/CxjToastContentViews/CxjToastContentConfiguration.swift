//
//  CxjToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

public enum CxjToastContentConfiguration {
    case iconed(config: CxjIconedToastConfiguration, titlesConfig: CxjToastTitlesConfiguration)
    case titled(config: CxjToastTitlesConfiguration)
    case custom(contentView: CxjToastContentView)
}

//
//  ConfigableToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 23/12/2024.
//

import UIKit

protocol ConfigableToast: ComparableToast, SpamProtectableToast {
    typealias Config = CxjToastConfiguration
    
    var config: Config { get }
}

extension ConfigableToast {
    var typeId: String { config.typeId }
    var placement: Placement { config.layout.placement }
    var sourceView: UIView { config.sourceView }
    var spamProtection: SpamProtection { config.spamProtection }
}

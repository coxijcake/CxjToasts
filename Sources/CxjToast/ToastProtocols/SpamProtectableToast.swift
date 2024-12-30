//
//  SpamProtectableToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 23/12/2024.
//

import Foundation

protocol SpamProtectableToast {
    typealias SpamProtection = CxjToastConfiguration.SpamProtection
    
    var spamProtection: SpamProtection { get }
}

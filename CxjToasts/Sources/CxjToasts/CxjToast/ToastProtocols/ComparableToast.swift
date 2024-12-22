//
//  ComparableToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 22/12/2024.
//

import UIKit

protocol ComparableToast: Sendable {
    typealias Placement = CxjToastConfiguration.Layout.Placement
    
    var typeId: String { get }
    var placement: Placement { get }
    var sourceView: UIView { get }
}

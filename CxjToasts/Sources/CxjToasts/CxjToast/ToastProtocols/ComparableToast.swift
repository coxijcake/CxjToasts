//
//  ComparableToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 22/12/2024.
//

import UIKit

protocol ComparableToast {
    typealias Placement = CxjToastConfiguration.Layout.Placement
    
	var typeId: CxjToastTypeid { get }
    var placement: Placement { get }
    var sourceView: UIView { get }
}

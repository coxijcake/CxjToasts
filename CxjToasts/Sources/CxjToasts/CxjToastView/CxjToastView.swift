//
//  File.swift
//  
//
//  Created by Nikita Begletskiy on 18/08/2024.
//

import UIKit

public protocol CxjToastView: UIView {
    typealias Configuration = CxjToastViewConfiguration
    
    //TODO: - Better naming
    func prepareToDisplay()
}

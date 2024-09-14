//
//  CxjAnimation+NativeToast.swift
//
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

public extension CxjAnimation {
    static let nativeToastPresenting = CxjAnimation { (animations, completion) in
        UIView.animate(
            withDuration: 1.0,
            delay: .zero,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 10.0,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
    
    static let nativeToastDismissing = CxjAnimation { (animations, completion) in
        UIView.animate(
            withDuration: 0.25,
            delay: .zero,
            options: [.curveEaseIn, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
}

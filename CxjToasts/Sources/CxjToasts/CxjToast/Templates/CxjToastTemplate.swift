//
//  CxjToastTemplate.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

//MARK: - Types
extension CxjToastTemplate {
	public typealias ViewConfig = CxjToastViewConfiguration
	public typealias ToastConfig = CxjToastConfiguration
}

//MARK: - Themes
public enum CxjToastTemplate {
    //MARK: - Info toasts
	case native(data: NativeToastData)
	case bottomPrimary(data: BottomPrimaryToastData)
	case topStraight(data: TopStraightToastData)
    case minimalizedGlobalStatus(data: MinimaliedGlobalStatusToastData)
    case compactActionDescription(data: CompactActionDescriptionToastData)
    
    //MARK: - Action toasts
	case compactAction(data: CompactActionToastData)
	case undoAction(data: UndoActionToastData)
}

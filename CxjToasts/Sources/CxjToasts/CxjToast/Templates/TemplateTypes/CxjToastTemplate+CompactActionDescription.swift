//
//  CxjToastTemplate+CompactActionDescription.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 19/12/2024.
//

import UIKit

extension CxjToastTemplate {
    public struct CompactActionDescriptionToastData {
        public typealias Title = CxjTextConfiguration
        public typealias Background = CxjToastViewConfiguration.Background
        
        public let typeId: String
        public let title: Title
        public let background: Background
        public let customSourceView: UIView?
        
        public init(
            typeId: String,
            title: Title,
            background: Background,
            customSourceView: UIView?
        ) {
            self.typeId = typeId
            self.title = title
            self.background = background
            self.customSourceView = customSourceView
        }
    }
}

//
//  CxjToastTemplate+MinimalizedGlobalStatus.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 17/12/2024.
//

import Foundation

extension CxjToastTemplate {
    public struct MinimaliedGlobalStatusToastData {
        public typealias Title = CxjTextConfiguration
        public typealias Icon = CxjIconConfiguration
        public typealias Background = CxjToastViewConfiguration.Background
        public typealias DismissMethods = Set<CxjToastConfiguration.DismissMethod>
        
        public let typeId: String
        public let icon: Icon?
        public let title: Title
        public let background: Background
        public let dismissMethods: DismissMethods
        
        public init(
            typeId: String,
            icon: Icon?,
            title: Title,
            background: Background,
            dismissMethods: DismissMethods
        ) {
            self.typeId = typeId
            self.icon = icon
            self.title = title
            self.background = background
            self.dismissMethods = dismissMethods
        }
    }
}

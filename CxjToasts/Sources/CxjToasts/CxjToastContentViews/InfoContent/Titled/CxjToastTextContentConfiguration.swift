//
//  CxjToastTextContentConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 07/12/2024.
//

import UIKit


public enum CxjToastTextContentConfiguration {
	case title(labelConfig: CxjLabelConfiguration)
	case withSubtitle(titleLabelConfig: CxjLabelConfiguration, subtitleLabelConfig: CxjLabelConfiguration, subtitleParams: SubtitledContentParams)
}

extension CxjToastTextContentConfiguration {
	public struct SubtitledContentParams {
		public let labelsPadding: CGFloat
		
		public init(
			labelsPadding: CGFloat = 4
		) {
			self.labelsPadding = labelsPadding
		}
	}
}

//
//  CxjToastTextContentConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 07/12/2024.
//

import UIKit


/// Configuration for text-based content in a toast.
///
/// Use this enumeration to define the layout and appearance of text-based content,
/// including optional subtitles and custom paddings between text labels.
public enum CxjToastTextContentConfiguration {
	
	/// A simple configuration with only a title.
	///
	/// - Parameter labelConfig: The configuration for the title label.
	case title(labelConfig: CxjLabelConfiguration)
	
	/// A configuration with both a title and a subtitle.
	///
	/// - Parameters:
	///   - titleLabelConfig: The configuration for the title label.
	///   - subtitleLabelConfig: The configuration for the subtitle label.
	///   - subtitleParams: Parameters for customizing the layout of the title and subtitle labels.
	case withSubtitle(titleLabelConfig: CxjLabelConfiguration, subtitleLabelConfig: CxjLabelConfiguration, subtitleParams: SubtitledContentParams)
}

extension CxjToastTextContentConfiguration {
	
	/// Parameters for configuring subtitled text content in a toast.
	public struct SubtitledContentParams {
		/// The vertical padding between the title and subtitle labels.
		public let labelsPadding: CGFloat
		
		/// Initializes the parameters for subtitled content.
		///
		/// - Parameter labelsPadding: The vertical padding between the title and subtitle labels.
		///   Defaults to `4`.
		public init(labelsPadding: CGFloat = 4) {
			self.labelsPadding = labelsPadding
		}
	}
}

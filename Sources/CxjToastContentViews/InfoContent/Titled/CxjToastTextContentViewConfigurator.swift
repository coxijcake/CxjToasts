//
//  CxjToastTextContentViewConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 07/12/2024.
//

import UIKit

@MainActor
enum CxjToastTextContentViewConfigurator {
	typealias Config = CxjToastTextContentConfiguration
	typealias View = CxjToastTextContentView
	
	static func viewWithConfig(_ config: Config) -> View {
		let viewConfig: View.Config
		
		switch config {
		case .title(labelConfig: let labelConfig):
			let label: UILabel = CxjTextContentLabelConfigurator.labelForConfig(labelConfig)
			viewConfig = .singleTitle(label: label)
		case .withSubtitle(
			titleLabelConfig: let titleLabelConfig,
			subtitleLabelConfig: let subtitleLabelConfig,
			subtitleParams: let subtitleParams
		):
			let titleLabel: UILabel = CxjTextContentLabelConfigurator.labelForConfig(titleLabelConfig)
			let subtitleLabel: UILabel = CxjTextContentLabelConfigurator.labelForConfig(subtitleLabelConfig)
			
			viewConfig = .withSubtitle(
				titleLabel: titleLabel,
				subtitleLabel: subtitleLabel,
				params: .init(labelsPadding: subtitleParams.labelsPadding)
			)
		}
		
		let view: CxjToastTextContentView = CxjToastTextContentView(config: viewConfig)
		
		return view
	}
}

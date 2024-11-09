//
//  TemplatedToastsListDiffableDataSource.swift
//  Example
//
//  Created by Nikita Begletskiy on 06/11/2024.
//

import UIKit

extension TemplatedToastsListDiffableDataSource {
	typealias DiffableDataSource = UICollectionViewDiffableDataSource<SectionIdentifier, TemplateType>
	typealias DiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, TemplateType>
	
	enum SectionIdentifier: Hashable, Equatable {
		case templatesList
	}
	
	enum TemplateType: Hashable, Equatable, CaseIterable {
		case native
		case bottomPrimary
		
		var title: String {
			switch self {
			case .native: "Native"
			case .bottomPrimary: "Bottom Primary"
			}
		}
	}
}


final class TemplatedToastsListDiffableDataSource {
	private let templateTypes: [TemplateType] = TemplateType.allCases
	
	private lazy var diffableDataSource: DiffableDataSource = diffableDataSourceFor(collectionView: collectionView)
	
	let collectionView: UICollectionView
	
	init(collectionView: UICollectionView) {
		self.collectionView = collectionView
	}
}

extension TemplatedToastsListDiffableDataSource {
	func sectionIdentifier(for index: Int) -> SectionIdentifier? {
		diffableDataSource.sectionIdentifier(for: index)
	}
	
	func itemIdentifier(for indexPath: IndexPath) -> TemplateType? {
		diffableDataSource.itemIdentifier(for: indexPath)
	}
	
	func reloadData(animated: Bool = true, completion: (() -> Void)? = nil) {
		var snapshot: DiffableDataSourceSnapshot = DiffableDataSourceSnapshot()
		
		snapshot.appendSections([SectionIdentifier.templatesList])
		snapshot.appendItems(templateTypes, toSection: .templatesList)
		
		diffableDataSource.apply(snapshot, animatingDifferences: animated, completion: completion)
	}
}

private extension TemplatedToastsListDiffableDataSource {
	func diffableDataSourceFor(collectionView: UICollectionView) -> DiffableDataSource {
		return DiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
			guard
				let cell: TemplatedToastCell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplatedToastCell.reuseIdentifier, for: indexPath) as? TemplatedToastCell
			else { return nil }
			
			cell.configure(title: itemIdentifier.title)
			
			return cell
		}
	}
}

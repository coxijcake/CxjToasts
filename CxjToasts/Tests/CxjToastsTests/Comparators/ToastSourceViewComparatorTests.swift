//
//  ToastSourceViewComparatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/12/2024.
//

import Testing
import UIKit

@testable import CxjToasts

@MainActor
final class ToastSourceViewComparatorTests {
    
    //MARK: - Tests
    @Test
    func testIsEqualsWithIdenticalViews() throws {
        let view = UIView()
        let comparator = ToastSourceViewComparator(lhs: view, rhs: view)
        
        #expect(comparator.isEquals() == true)
    }
    
    @Test
    func testIsEqualsWithDifferentViews() throws {
        let view1 = UIView()
        let view2 = UIView()
        let comparator = ToastSourceViewComparator(lhs: view1, rhs: view2)
        
        #expect(comparator.isEquals() == false)
    }
    
    @Test
    func testIsEqualsWithIdenticalFramesButDifferentInstances() throws {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let comparator = ToastSourceViewComparator(lhs: view1, rhs: view2)
        
        #expect(comparator.isEquals() == false)
    }
    
    @Test
    func testIsEqualsWithSameInstanceInDifferentVariables() throws {
        let view = UIView()
        let anotherReferenceToView = view
        let comparator = ToastSourceViewComparator(lhs: view, rhs: anotherReferenceToView)
        
        #expect(comparator.isEquals() == true)
    }
}

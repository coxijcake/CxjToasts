//
//  ToastSpamValidatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 22/12/2024.
//

#if canImport(Testing)

import UIKit
import Testing

@testable import CxjToasts

@MainActor
final class ToastSpamValidatorTests {
    //MARK: - Types
    struct MockToast: SpamProtectableToast, ComparableToast {
        let spamProtection: SpamProtection
        let typeId: CxjToastTypeid
        let placement: Placement
        let sourceView: UIView
    }

    // MARK: - Tests
    @Test
    func testCouldBeDisplayedToastWithSpamProtectionOff() throws {
        let displayingToast: MockToast = MockToast(
            spamProtection: .off,
            typeId: "type1",
            placement: .center,
            sourceView: UIView()
        )

        let displayingToasts: [MockToast] = [
            displayingToast
        ]

        let toastToDisplay = MockToast(
            spamProtection: .off,
            typeId: displayingToast.typeId,
            placement: displayingToast.placement,
            sourceView: displayingToast.sourceView
        )

        let validator = ToastSpamValidator(displayingToasts: displayingToasts)

        #expect(validator.couldBeDisplayedToast(toastToDisplay) == true)
    }

    @Test
    func testCouldBeDisplayedToastWithNoMatchingAttributes() throws {
        let displayingToasts: [MockToast] = [
            MockToast(
                spamProtection: .on(comparisonCriteria: .init(
                    attibutes: [.type],
                    rule: .or
                )),
                typeId: "type1",
                placement: .center,
                sourceView: UIView()
            )
        ]

        let toastToDisplay = MockToast(
            spamProtection: .on(comparisonCriteria: .init(
                attibutes: [.type],
                rule: .or
            )),
            typeId: "type2",
            placement: .bottom(params: .init(offset: 10, includingSafeArea: false)),
            sourceView: UIView()
        )

        let validator = ToastSpamValidator(displayingToasts: displayingToasts)

        #expect(validator.couldBeDisplayedToast(toastToDisplay) == true)
    }

    @Test
    func testCouldBeDisplayedToastWithMatchingAttributesOrLogic() throws {
        let sourceView = UIView()

        let displayingToasts: [MockToast] = [
            MockToast(
                spamProtection: .on(comparisonCriteria: .init(
                    attibutes: [.type, .sourceView, .placement(includingYOffset: false)],
                    rule: .or
                )),
                typeId: "type1",
                placement: .center,
                sourceView: sourceView
            )
        ]

        let toastToDisplay = MockToast(
            spamProtection: .on(comparisonCriteria: .init(
                attibutes: [.type, .sourceView, .placement(includingYOffset: false)],
                rule: .or
            )),
            typeId: "type2", // Different typeId
            placement: .center, // Same placement
            sourceView: sourceView // Same sourceView
        )

        let validator = ToastSpamValidator(displayingToasts: displayingToasts)

        #expect(validator.couldBeDisplayedToast(toastToDisplay) == false)
    }

    @Test
    func testCouldBeDisplayedToastWithMatchingAttributesAndLogic() throws {
        let displayingToast: MockToast = MockToast(
            spamProtection: .on(comparisonCriteria: .init(
                attibutes: [.type, .placement(includingYOffset: true), .sourceView],
                rule: .and
            )),
            typeId: "type1",
            placement: .center,
            sourceView: UIView()
        )

        let displayingToasts: [MockToast] = [
            displayingToast
        ]

        let toastToDisplay = MockToast(
            spamProtection: displayingToast.spamProtection,
            typeId: "type1",
            placement: displayingToast.placement,
            sourceView: displayingToast.sourceView
        )

        let validator = ToastSpamValidator(displayingToasts: displayingToasts)

        #expect(validator.couldBeDisplayedToast(toastToDisplay) == false)
    }

    @Test
    func testCouldBeDisplayedToastWithDifferentAttributeAndLogicAnd() throws {
        let displayingToast: MockToast = MockToast(
            spamProtection: .on(comparisonCriteria: .init(
                attibutes: [.type, .placement(includingYOffset: true), .sourceView],
                rule: .and
            )),
            typeId: "type1",
            placement: .center,
            sourceView: UIView()
        )

        let displayingToasts: [MockToast] = [
            displayingToast
        ]

        let toastToDisplay = MockToast(
            spamProtection: displayingToast.spamProtection,
            typeId: "type2", // Different typeId
            placement: displayingToast.placement,
            sourceView: displayingToast.sourceView
        )

        let validator = ToastSpamValidator(displayingToasts: displayingToasts)

        #expect(validator.couldBeDisplayedToast(toastToDisplay) == true)
    }

    @Test
    func testCouldBeDisplayedToastWithEmptyAttributesAndLogic() throws {
        let displayingToast: MockToast = MockToast(
            spamProtection: .on(comparisonCriteria: .init(
                attibutes: [],
                rule: .and
            )),
            typeId: "type1",
            placement: .center,
            sourceView: UIView()
        )

        let displayingToasts: [MockToast] = [
            displayingToast
        ]

        let toastToDisplay = MockToast(
            spamProtection: displayingToast.spamProtection,
            typeId: "type2",
            placement: .bottom(params: .init(offset: 20, includingSafeArea: true)),
            sourceView: UIView()
        )

        let validator = ToastSpamValidator(displayingToasts: displayingToasts)

        #expect(validator.couldBeDisplayedToast(toastToDisplay) == false)
    }
    
    @Test
    func testCouldBeDisplayedToastWithEmptyAttributesOrLogic() throws {
        let displayingToast: MockToast = MockToast(
            spamProtection: .on(comparisonCriteria: .init(
                attibutes: [],
                rule: .or
            )),
            typeId: "type1",
            placement: .center,
            sourceView: UIView()
        )

        let displayingToasts: [MockToast] = [
            displayingToast
        ]

        let toastToDisplay = MockToast(
            spamProtection: displayingToast.spamProtection,
            typeId: "type2",
            placement: .bottom(params: .init(offset: 20, includingSafeArea: true)),
            sourceView: UIView()
        )

        let validator = ToastSpamValidator(displayingToasts: displayingToasts)

        #expect(validator.couldBeDisplayedToast(toastToDisplay) == true)
    }
}

#endif

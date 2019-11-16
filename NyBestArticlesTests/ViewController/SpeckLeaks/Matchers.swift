//  Contacts
//
//  Created by sadman samee on 10/9/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
import Nimble
import Quick

public func leak() -> Predicate<LeakTest> {
    Predicate.simple("leak") { expression in

        guard let leakTest = try expression.evaluate() else {
            return PredicateStatus.fail
        }

        return PredicateStatus(bool: leakTest.isLeaking())
    }
}

public func leakWhen<P>(_ action: @escaping (P) -> Any) -> Predicate<LeakTest> where P: AnyObject {
    Predicate.simple("leak when") { expression in

        guard let leakTest = try expression.evaluate() else {
            return PredicateStatus.fail
        }

        return leakTest.isLeaking(when: action)
    }
}

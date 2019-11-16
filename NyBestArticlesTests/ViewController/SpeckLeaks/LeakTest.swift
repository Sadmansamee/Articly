//  Contacts
//
//  Created by sadman samee on 10/9/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Nimble
import Quick

// public typealias LeakTestConstructor = () -> AnyObject

public struct LeakTest {
    let constructor: LeakTestConstructor

    public init(constructor: @escaping LeakTestConstructor) {
        self.constructor = constructor
    }

    internal func isLeaking() -> Bool {
        weak var leaked: AnyObject?

        autoreleasepool {
            var evaluated: AnyObject? = self.constructor()

            // To call viewDidLoad on the vc
            view(evaluated)

            leaked = evaluated
            evaluated = nil
        }

        return leaked != nil
    }

    internal func isLeaking<P>(when action: (P) -> Any) -> PredicateStatus where P: AnyObject {
        weak var leaked: AnyObject?

        var failed = false
        var actionResult: Any?

        autoreleasepool {
            var evaluated: P? = self.constructor() as? P

            if evaluated == nil {
                failed = true
            } else {
                actionResult = action(evaluated!)

                // To call viewDidLoad on the vc
                view(evaluated)

                leaked = evaluated
                evaluated = nil
            }
        }

        if failed || actionResult == nil {
            return PredicateStatus.fail
        }

        return PredicateStatus(bool: leaked != nil)
    }
}

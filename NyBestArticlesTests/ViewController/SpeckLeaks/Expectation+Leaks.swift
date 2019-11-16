//  Contacts
//
//  Created by sadman samee on 10/9/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
import Nimble

public typealias LeakTestConstructor = () -> AnyObject

extension Expectation where T == LeakTestConstructor {
    public func toNotLeak(timeout _: TimeInterval = AsyncDefaults.Timeout, pollInterval _: TimeInterval = AsyncDefaults.PollInterval, description _: String? = nil, shouldFail: Bool = false) {
        do {
            guard let constructor = try expression.evaluate() else {
                fail()
                return
            }
            AnalyzeLeak().execute(constructor: constructor, shouldLeak: shouldFail)
        } catch {
            fail()
        }
    }

    public func toLeak() {
        toNotLeak(timeout: AsyncDefaults.Timeout, pollInterval: AsyncDefaults.PollInterval, description: nil, shouldFail: true)
    }

    public func toNotLeakWhen<P>(shouldFail: Bool = false, _ action: (P) -> Void) where P: AnyObject {
        do {
            guard let constructor = try expression.evaluate() else {
                fail()
                return
            }
            let castedConstructor: () -> P = {
                constructor() as! P
            }

            AnalyzeLeakAction().execute(constructor: castedConstructor, action: action, shouldLeak: shouldFail)
        } catch {
            fail()
        }
    }

    public func toLeakWhen<P>(shouldFail _: Bool = false, _ action: (P) -> Void) where P: AnyObject {
        toNotLeakWhen(shouldFail: true, action)
    }

    public func toNotLeakWhen<P>(shouldFail: Bool = false, _ action: (P) -> Any) where P: AnyObject {
        do {
            guard let constructor = try expression.evaluate() else {
                fail()
                return
            }
            let castedConstructor: () -> P = {
                constructor() as! P
            }

            AnalyzeLeakAction().execute(constructor: castedConstructor, action: action, shouldLeak: shouldFail)
        } catch {
            fail()
        }
    }

    public func toLeakWhen<P>(shouldFail _: Bool = false, _ action: (P) -> Any) where P: AnyObject {
        toNotLeakWhen(shouldFail: true, action)
    }
}

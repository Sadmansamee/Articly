//  Contacts
//
//  Created by sadman samee on 10/9/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
#if os(iOS) || os(watchOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif

import Nimble
import Quick

struct AnalyzeLeakAction {
    func execute<T>(constructor: () -> T, action: (T) -> Void, shouldLeak: Bool = false) where T: AnyObject {
        var mayBeLeaking: T?
        let leaksAnalyzer = LeaksAnalyzer()

        autoreleasepool {
            leaksAnalyzer.leakedObject = nil

            // Instantiate the object that will be analyzed
            mayBeLeaking = constructor()

            // To call viewDidLoad on the vc
            view(mayBeLeaking)

            leaksAnalyzer.analize(mayBeLeaking!)

            // Run the action that will be analyzed
            action(mayBeLeaking!)

            // Set to nil. If the analyzer still has an instance, that's a leak
            mayBeLeaking = nil
        }

        if shouldLeak {
            expect(leaksAnalyzer.leakedObject).toEventuallyNot(beNil())
        } else {
            expect(leaksAnalyzer.leakedObject).toEventually(beNil())
        }
    }

    func execute<T>(constructor: () -> T, action: (T) -> Any, shouldLeak: Bool = false) where T: AnyObject {
        var mayBeLeaking: T?
        let leaksAnalyzer = LeaksAnalyzer()

        var resultThatMightCauseLeak: Any?

        autoreleasepool {
            leaksAnalyzer.leakedObject = nil

            // Instantiate the object that will be analyzed
            mayBeLeaking = constructor()

            // To call viewDidLoad on the vc
            view(mayBeLeaking)

            leaksAnalyzer.analize(mayBeLeaking!)

            // Run the action that will be analyzed

            resultThatMightCauseLeak = action(mayBeLeaking!)

            // Set to nil. If the analyzer still has an instance, that's a leak
            mayBeLeaking = nil
        }

        if shouldLeak {
            expect(leaksAnalyzer.leakedObject).toEventuallyNot(beNil())
        } else {
            expect(resultThatMightCauseLeak).toNot(beNil())
            expect(leaksAnalyzer.leakedObject).toEventually(beNil())
        }
    }
}

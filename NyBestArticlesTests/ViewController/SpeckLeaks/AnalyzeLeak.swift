//  Contacts
//
//  Created by sadman samee on 10/9/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

#if os(iOS) || os(watchOS) || os(tvOS)
    import UIKit

    public typealias OSViewController = UIViewController
#elseif os(macOS)
    import Cocoa

    public typealias OSViewController = NSViewController
#endif

import Nimble
import Quick

func view(_ viewController: AnyObject?) {
    if let viewController = viewController as? OSViewController {
        _ = viewController.view // To call viewDidLoad on the vc
    }
}

public func getOSViewController() -> OSViewController {
    OSViewController()
}

struct AnalyzeLeak {
    func execute(constructor: LeakTestConstructor, shouldLeak: Bool = false) {
        var mayBeLeaking: AnyObject?
        let leaksAnalyzer = LeaksAnalyzer()

        autoreleasepool {
            leaksAnalyzer.leakedObject = nil

            mayBeLeaking = constructor()

            view(mayBeLeaking)

            leaksAnalyzer.analize(mayBeLeaking!)
            mayBeLeaking = nil
        }

        if shouldLeak {
            expect(leaksAnalyzer.leakedObject).toEventuallyNot(beNil())
        } else {
            expect(leaksAnalyzer.leakedObject).toEventually(beNil())
        }
    }
}

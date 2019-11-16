//  Contacts
//
//  Created by sadman samee on 10/9/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

class LeaksAnalyzer {
    weak var leakedObject: AnyObject?

    func analize(_ leakingObject: AnyObject) {
        leakedObject = leakingObject
    }
}

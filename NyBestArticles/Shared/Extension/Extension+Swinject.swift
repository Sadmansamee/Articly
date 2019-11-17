//
//  Extension.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension Container {
    /**
     Retrieves UIViewController of the specified type. The UIViewController must conform to StoryboardLodable

     - Parameter serviceType: UIViewController type
     - Returns: UIViewController of specified type
     */
    func resolveViewController<ViewController: StoryboardLoadable>(_ serviceType: ViewController.Type)
        -> ViewController {
        let storyboard = SwinjectStoryboard.create(name: serviceType.storyboardName, bundle: nil, container: self)
        let name = "\(serviceType)".replacingOccurrences(of: "ViewController", with: "")
        return storyboard.instantiateViewController(withIdentifier: name) as! ViewController
    }
}

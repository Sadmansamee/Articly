//
//  Extension+RX.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift

infix operator <->: DefaultPrecedence

func <-> <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    if T.self == String.self {}

    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            relay.accept(n)
        }, onCompleted: {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}

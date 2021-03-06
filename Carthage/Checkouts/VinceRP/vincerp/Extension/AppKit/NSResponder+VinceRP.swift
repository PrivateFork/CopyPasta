//
// Created by Agnes Vasarhelyi on 04/11/15.
// Copyright (c) 2015 Viktor Belenyesi. All rights reserved.
//

import AppKit

public extension NSResponder {

    public func reactiveProperty<T>(forProperty propertyName: String, initValue: T, initializer: ((Source<T>) -> ())? = nil) -> Hub<T> {
        return ReactivePropertyGenerator.property(self, propertyName: propertyName, initValue: initValue, initializer: initializer)
    }

    public func reactiveEmitter<T>(name propertyName: String, initValue: T) -> Source<T> {
        return ReactivePropertyGenerator.source(self, propertyName: propertyName, initValue: initValue)
    }

}

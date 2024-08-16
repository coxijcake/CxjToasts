//
//  CxjToasts.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

public enum CxjToasts {
    
}

extension CxjToasts {
    final class MulticastDelegate<T> {
        private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()

        func add(_ delegate: T) {
            delegates.add(delegate as AnyObject)
        }
        
        func remove(_ delegateToRemove: T) {
            for delegate in delegates.allObjects.reversed() {
                if delegate === delegateToRemove as AnyObject {
                    delegates.remove(delegate)
                }
            }
        }
        
        func invoke(_ invocation: (T) -> Void) {
            for delegate in delegates.allObjects.reversed() {
                invocation(delegate as! T)
            }
        }
    }
}

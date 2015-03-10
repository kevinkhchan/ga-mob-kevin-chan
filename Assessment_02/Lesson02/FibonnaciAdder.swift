//
//  FibonnaciAdder.swift
//  Lesson02
//
//  Created by Kevin Chan on 10/03/2015.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation

class FibonacciAdder {
    //properties
    var fibonacci: [Int] = [0, 1]
    var indexOfFibonacciNumber: Int
    
    //method
    var fibonacciNumberAtIndex: Int {
        get {
            // return the computed property
            while fibonacci.count < indexOfFibonacciNumber {
                fibonacci.append(fibonacci[fibonacci.count - 2] + fibonacci[fibonacci.count - 1])
            }
            return fibonacci[indexOfFibonacciNumber-1]
        }
    }
    
    //init
    init (indexOfFibonacciNumber: Int) {
        self.indexOfFibonacciNumber = indexOfFibonacciNumber
    }
}
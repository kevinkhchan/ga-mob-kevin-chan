//
//  FibonnaciAdder.swift
//  Lesson02
//
//  Created by Kevin Chan on 10/03/2015.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation

class FibonacciAdder {
    // properties - declare the variables to be used
    // fibonacci will be an array containing the sequence
    // of Fibonacci numbers. indexOfFibonacciNumber will
    // contain the integer passed through
    var fibonacci: [Int] = [0, 1]
    var indexOfFibonacciNumber: Int
    
    // method
    var fibonacciNumberAtIndex: Int {
        get {
            // return the computed property
            while fibonacci.count < indexOfFibonacciNumber {
                fibonacci.append(fibonacci[fibonacci.count - 2] + fibonacci[fibonacci.count - 1])
            }
            // ensure that the value returned is 1 less than
            // the index number as the array index starts at 0
            return fibonacci[indexOfFibonacciNumber-1]
        }
    }
    
    // init the indexOfFibonacciNumber variable with the
    // integer passed through
    init (indexOfFibonacciNumber: Int) {
        self.indexOfFibonacciNumber = indexOfFibonacciNumber
    }
}
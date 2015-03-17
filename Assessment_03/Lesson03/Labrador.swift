//
//  Labrador.swift
//  Lesson03
//
//  Created by Kevin Chan on 17/03/2015.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import UIKit

class Labrador: Dog {
    override func prettyAnimalName() -> String {
        return "Labrador name: " + self.name
    }
}
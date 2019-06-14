//
//  Person.swift
//  AnchorPointAssessment6
//
//  Created by Kaden Hendrickson on 6/14/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

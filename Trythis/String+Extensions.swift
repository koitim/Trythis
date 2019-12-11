//
//  String+Extensions.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
    func replace(_ of: String, with: String) -> String {
        let s = self.replacingOccurrences(of: of, with: with)
        return s
    }
    func url() -> URL {
        return URL(string: self)!
    }
    func count() -> Int {
        return self.characters.count
    }
}

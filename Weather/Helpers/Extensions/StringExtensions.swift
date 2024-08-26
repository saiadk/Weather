//
//  StringExtensions.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

extension String {
    func removingPrefixes(_ prefixes: [String]) -> String {
        let pattern = "^(\(prefixes.map{"\\Q"+$0+"\\E"}.joined(separator: "|")))\\s?"
        guard let range = self.range(of: pattern, options: [.regularExpression, .caseInsensitive]) else { return self }
        return String(self[range.upperBound...])
    }
}

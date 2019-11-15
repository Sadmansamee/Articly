//
//  Extension+Date.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

extension String {
    func toDate(withFormat format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else { return Date() }
        return date
    }

    func toString(withFormat format: String, toFormat: String) -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.calendar = Calendar(identifier: .gregorian)
        dateFormatterInput.dateFormat = format

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.calendar = Calendar(identifier: .gregorian)
        dateFormatterOutput.dateFormat = toFormat

        guard let dateInput = dateFormatterInput.date(from: self) else { return dateFormatterOutput.string(from: Date()) }

        return dateFormatterOutput.string(from: dateInput)
    }
}

extension Date {
    func toString(toFormat: String) -> String? {
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.calendar = Calendar(identifier: .gregorian)
        dateFormatterOutput.dateFormat = toFormat
        return dateFormatterOutput.string(from: self)
    }
}

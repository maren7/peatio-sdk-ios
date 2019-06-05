//
//  DateTools.swift
//  PXN
//
//  Created by iCell on 2018/5/2.
//  Copyright © 2018 one.pxn. All rights reserved.
//

import Foundation

final class DateToolFormatter {
    static let shared = DateToolFormatter()

    var formatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter
    }()
}

final class DateTools {
    static let defaultFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    static let internetDateTimeExtendedFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    /// 将某种格式的日期 string 转换成 date
    static func dateFrom(string: String) -> Date? {
        let formatter = DateToolFormatter.shared.formatter
        formatter.dateFormat = defaultFormat
        if let defaultISO8601Value = formatter.date(from: string) {
            return defaultISO8601Value
        }

        formatter.dateFormat = internetDateTimeExtendedFormat
        if let internetDateTimeExtendedValue = formatter.date(from: string) {
            return internetDateTimeExtendedValue
        }
        return nil
    }
}

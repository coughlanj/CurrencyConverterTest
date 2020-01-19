//
//  DateFormatter.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 19/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

struct DateFormatHelper {
   
   enum DateFormat: String {
      case api = "YYYY-MM-DD"
      case display = "DD MMM"
   }
   
   static private let dateFormatter = DateFormatter()
   
   // MARK: - Static
   
   /**
   Simple func to covert a date to a string
    - parameters:
      - date: the date to convert to string
      - format:  the DateFormat enum to format the date
    */
   static func dateToString(date: Date, format: DateFormat) -> String {
      DateFormatHelper.dateFormatter.dateFormat = format.rawValue
      return DateFormatHelper.dateFormatter.string(from: date)
   }
   
   /**
   Simple func to covert a string to a date
    - parameters:
      - dateString: the string to convert to date
      - format:  the DateFormat enum that the string is formatted in
    */
   static func stringToDate(dateString: String, format: DateFormat) -> Date? {
      DateFormatHelper.dateFormatter.dateFormat = format.rawValue
      return DateFormatHelper.dateFormatter.date(from: dateString)
   }
   
   /**
   Simple func to convert a date string of one format into a string of a different format
    - parameters:
      - dateString: the date string in 'inFormat'
      - inFormat: the format of 'dateString'
      - outFormat: the desired output format
    */
   static func stringToFormattedString(dateString: String, inFormat: DateFormat, outFormat: DateFormat) -> String? {
      if let date = stringToDate(dateString: dateString, format: .api) {
         return dateToString(date: date, format: .display)
      }
      return nil
   }
}

//
//  String+Extensions.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 29/04/2023.
//

import Foundation

extension String {
    
    var dateFormatted: String {
        
        var dateStr = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEE, dd MMM,yyyy"

        if let date = dateFormatterGet.date(from: self) {
            dateStr = dateFormatterPrint.string(from: date)
        }
        return dateStr
    }
    
    
}

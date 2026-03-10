//
//  Date+Extension.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//

import Foundation

extension String {
    
    func toDisplayDate() -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy"
        
        return outputFormatter.string(from: date)
    }
}

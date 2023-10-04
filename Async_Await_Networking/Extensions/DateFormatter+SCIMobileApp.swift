//
//  DateFormatter+SCIMobileApp.swift
//  Async_Await_Networking
//
//  Created by Abdul-Salaam, Rashad (Penske, Insight Global) on 9/28/23.
//

import Foundation

extension DateFormatter {
    
    static let sciInputDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'" // 2023-09-09T15:10:53Z

        return df
    }()
    
    static let sciHumanReadableOutputDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM d, h:mm a"
        df.locale = Locale.autoupdatingCurrent
        return df
    }()
    
    static func makeHumanReadableDateString(inputDateString: String) -> String {
        
        guard let date = DateFormatter.sciInputDateFormatter.date(from: inputDateString) else { return "Error: Cannot format DateString" }
        
        let formattedDateStr = DateFormatter.sciHumanReadableOutputDateFormatter.string(from: date)
        return formattedDateStr
    }
}

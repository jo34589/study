//
//  WeekOfTheDayCalc.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import Foundation

var week: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]


func weekOfDay(of date: Date) -> Int {
    //sun = 0 , sat = 6
    //1970 1 1 목요일 = 4
    let aDay:Double = 86400
    let date = Date().timeIntervalSince1970
    let first = 4
    
    return (Int(date/aDay)%7 + first)%7
}

func toMonthString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "M"
    return formatter.string(from: date)
}

func toYearString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter.string(from: date)
}

func toDayString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return formatter.string(from: date)
}

func firstWeekOfDay(of date: Date) -> Int {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    
    let dateStr = formatter.string(from: date)
    if dateStr == "1" {
        return weekOfDay(of: date)
    } else {
        guard let dayPassed = Int(dateStr) else {
            //error
            return -1
        }
        let weekOfDayToday = weekOfDay(of: date)
        let daysToGoBack = (dayPassed-1)%7
        let rtn = weekOfDayToday - daysToGoBack
        if rtn >= 0 {
            return rtn
        } else {
            return rtn+7
        }
    }
}

func isLeapYear(year: Int) -> Bool {
    if year % 400 == 0 {
        return true
    } else if year % 100 == 0 {
        return false
    } else if year % 4 == 0 {
        return true
    } else {
        return false
    }
}

func lastMonthDayCalc(isLeapYear: Bool, month: Int) -> Int {
    switch month {
    case 1, 2, 4, 6, 8, 9, 11:
        return 31
    case 3:
        if isLeapYear {
            return 29
        } else {
            return 28
        }
    case 5, 7, 10, 12:
        return 30
    default:
        //error
        return -1
    }
}

func thisMonthDayCalc(isLeapYear: Bool, month: Int) -> Int {
    switch month {
    case 1, 3, 5, 7, 8, 10, 12:
        return 31
    case 2:
        if isLeapYear {
            return 29
        } else {
            return 28
        }
    case 4, 6, 9, 11:
        return 30
    default:
        //error
        return -1
    }
}

class dayParam {
    var columnIndex: Int
    var rowIndex: Int
    var firstWeekOfDay: Int
    var month: Int
    var year: Int
    
    init(columnIndex: Int, rowIndex: Int, firstDayOfWeek: Int, month: Int, year: Int) {
        self.columnIndex = columnIndex
        self.rowIndex = rowIndex
        self.firstWeekOfDay = firstDayOfWeek
        self.month = month
        self.year = year
    }
}

func dayCalc(columnIndex: Int, rowIndex: Int, firstDayOfWeek: Int, month: Int, year: Int) -> Int {
    let rowValue = rowIndex*7
    let isLeapYear = isLeapYear(year: year)
    let lastMonthDay = lastMonthDayCalc(isLeapYear: isLeapYear, month: month)
    let thisMonthDay = thisMonthDayCalc(isLeapYear: isLeapYear, month: month)
    
    let val = columnIndex + rowValue - firstDayOfWeek + 1
    if val <= 0 {
        return val + lastMonthDay
    } else if val > thisMonthDay {
        return val - thisMonthDay
    } else {
        return val
    }
}

func isThisMonth(rowIndex: Int, day: Int) -> Bool {
    if rowIndex == 0 && day > 7{
        return false
    } else if rowIndex == 4 && day < 21 {
        return false
    } else {
        return true
    }
}

func getDate(year: Int, month: Int, day: Int, rowIndex: Int) -> Date {
    var month = month
    var year = year
    if rowIndex == 0 && day > 7 {
        month -= 1
        if month == 0 {
            month = 12
            year -= 1
        }
    } else if rowIndex == 4 && day < 21 {
        month += 1
        if month == 13 {
            month = 1
            year += 1
        }
    }
    let dateString = "\(year).\(month).\(day)"
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.M.dd"
    
    return formatter.date(from: dateString)!
}

func getTitle(from date: Date?) -> String {
    guard let date = date else {
        return "error"
    }
    let weekOfDay = weekOfDay(of: date)
    let day = toDayString(date: date)
    let month = toMonthString(date: date)
    return "\(week[weekOfDay]) \(month).\(day)"
}

func getEndDate(from date: Date, duration: Int) -> Date {
    let aDay = 86400
    return date.addingTimeInterval(Double(duration*aDay))
}

func firstDayOfMonth(date: Date) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.M.dd"
    var str = formatter.string(from: date)
    str.removeLast(2)
    str.append("01")
    let rtn = formatter.date(from: str)!
    return rtn
}

func lastDayOfMonth(date: Date) -> Date {
    let year = toYearString(date: date)
    let month = Int(toMonthString(date: date))!
    let leapYear = isLeapYear(year: Int(year)!)
    var lastDay = 31
    if month == 2 {
        if leapYear {
            lastDay = 29
        } else {
            lastDay = 28
        }
    } else if month == 4 || month == 6 || month == 9 || month == 11 {
        lastDay = 30
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    var str = formatter.string(from: date)
    str.removeLast(2)
    str.append(String(lastDay))
    let rtn = formatter.date(from: str)!
    
    return rtn
}

func weekStartEnd(year: Int, month: Int, firstWeekOfDay: Int, row: Int) -> (Date, Date) {
    let aDay = 86400
    let baseStr = "\(year).\(month).1"
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.M.d"
    let baseDate = formatter.date(from: baseStr)!
    let timeIntervalToStart = Double(((row*7) - (firstWeekOfDay))*aDay)
    let timeIntervalToEnd = Double(((row*7) + ((7-firstWeekOfDay)))*aDay)
    let start = baseDate.addingTimeInterval(timeIntervalToStart)
    let end = baseDate.addingTimeInterval(timeIntervalToEnd)
    
    return (start, end)
}


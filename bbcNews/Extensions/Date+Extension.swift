//
//  Date+Extension.swift
//  JiboReminderHealthcare
//
//  Created by Marco Antonio Uzcategui Pescozo on 19/03/2018.
//  Copyright © 2018 Marco Antonio Uzcategui Pescozo. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func format(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func byAdding(component: Calendar.Component, value: Int) -> Date {
        
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    var yesterday: Date {
        
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var day: Int {
        
        return Calendar.current.component(.day, from: self)
    }
    
    var tomorrow: Date {
        
        return Calendar.current.date(byAdding: .day, value: +1, to: self)!
    }
    
    var month: Int {
        
        return Calendar.current.component(.month, from: self)
    }
    
    var year: Int {
        
        return Calendar.current.component(.year, from: self)
    }
    
    var lastMonth: Int {
        
        return self.month - 1
    }
    
    var yesterdayMonth: Int {
        
        return Calendar.current.component(.month, from: self.yesterday)
    }
    
    var firstDayMonth: Date {
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        let startOfMonth = Calendar.current.date(from: comp)!
        return startOfMonth
    }
    
    var lastDayMonth: Date {
        let year = Calendar.current.component(.year, from: self)
        let comp = DateComponents(calendar: Calendar.current, year: year, month: self.month + 1)
        let startDayOfNexMonth = Calendar.current.date(from: comp)!
        let lastDayMonth = startDayOfNexMonth.yesterday
        return lastDayMonth
    }
    
    var firstDayOfYesterdayMonth: Date {
        
        return self.yesterday.firstDayMonth
    }
    
    public static func createDate(day: Int,
                                  month: Int,
                                  year: Int) -> Date {
        
        return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
    }
    
    var mondayOfFirstWeekOfMonth: Date {
        
        let calendar = Calendar.current
        // Convertimos los indices de la semana por defecto Domingo 1, Lunes 2...Sabado 7 a Lunes 1, Martes 2... Domingo 7
        var dayOfWeek = calendar.component(.weekday, from: self.firstDayMonth) + 1 - calendar.firstWeekday
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        
        // Le restamos 1 al indice que nos de para luego restar tantos numeros de dias como valor nos resulte este weekIndex a self
        let weekIndex = dayOfWeek - 1
        
        return Calendar.current.date(byAdding: .day, value: -(abs(weekIndex)), to: self.firstDayMonth)!
        
    }
    
    var sundayOfLastWeekOfMonth: Date {
        
        let calendar = Calendar.current
        // Convertimos los indices de la semana por defecto Domingo 1, Lunes 2...Sabado 7 a Lunes 1, Martes 2... Domingo 7
        var dayOfWeek = calendar.component(.weekday, from: self.lastDayMonth) + 1 - calendar.firstWeekday
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        
        // Le restamos 1 al indice que nos de para luego sumar tantos numeros de dias como valor nos resulte este weekIndex a self
        
        let weekIndex = 7 - dayOfWeek
        
        return Calendar.current.date(byAdding: .day, value: +(abs(weekIndex)), to: self.lastDayMonth)!
    }
    
    static func getDateOfIndexMonth(monthIndex: Int) -> Date {
        
        let year = Calendar.current.component(.year, from: Date())
        let comp = DateComponents(calendar: Calendar.current, year: year, month: monthIndex)
        return Calendar.current.date(from: comp)!
    }
}

//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    switch to {
    case "USD":
        if (self.currency == "GBP"){
            return Money(amount: Int(self.amount * 2), currency: "USD")
        }else if (self.currency == "CAN"){
            return Money(amount: Int(self.amount * 4/5), currency: "USD")
        }else if(self.currency == "EUR"){
            return Money(amount: Int(self.amount * 2/3), currency: "USD")
        }else{
            return self;
        }
    case "EUR":
            if (self.currency == "USD"){
                return Money(amount: Int(self.amount * 3/2), currency: "EUR")
            }else if (self.currency == "GBP"){
                return Money(amount: Int(self.amount * 3), currency: "EUR")
            }else if(self.currency == "CAN"){
                return Money(amount: Int(self.amount * 6/5), currency: "EUR")
            }else{
                return self;
        }
    case "CAN":
        if (self.currency == "USD"){
            return Money(amount: Int(self.amount * 5/4), currency: "CAN")
        }else if (self.currency == "GBP"){
            return Money(amount: Int(self.amount * 5/2), currency: "CAN")
        }else if(self.currency == "EUR"){
            return Money(amount: Int(self.amount * 5/6), currency: "CAN")
        }else{
            return self;
        }
    case "GBP":
        if (self.currency == "USD"){
            return Money(amount: Int(self.amount * 1/2), currency: "GBP")
        }else if (self.currency == "CAN"){
            return Money(amount: Int(self.amount * 2/5), currency: "GBP")
        }else if(self.currency == "EUR"){
            return Money(amount: Int(self.amount * 1/3), currency: "GBP")
        }else{
            return self;
        }
    default:
        return self;
    }
  }
  
  public func add(_ to: Money) -> Money {
    return Money(amount:self.convert(to.currency).amount + to.amount , currency:to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    return Money(amount: self.amount - from.convert(self.currency).amount, currency: self.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type {
    case .Hourly(let val):
        return Int(val * Double(hours))
    case .Salary(let val):
        return val
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type {
    case .Hourly(let val):
        self.type = JobType.Hourly(val + amt)
    case .Salary(let val):
        self.type = JobType.Salary(val + Int(amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return self._job }
    set(value) {
        self._job = self.age > 15 ? value : nil
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return self._spouse }
    set(value) {
        self._spouse = self.age >= 18 ? value: nil
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self.job)) spouse:\(String(describing: self.spouse))]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    members.append(spouse1)
    members.append(spouse2)
  }
  
  open func haveChild(_ child: Person) -> Bool {
    for member in members {
        if member.age >= 21 {
            members.append(child)
            return true
        }
    }
    return false
  }
  
  open func householdIncome() -> Int {
    var res: Int = 0
    for member in members {
        if let job = member.job {
            res += job.calculateIncome(2000)
        }
    }
    return res
    }
}






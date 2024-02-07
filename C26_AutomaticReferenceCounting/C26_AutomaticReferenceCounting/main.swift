//
//  main.swift
//  C26_AutomaticReferenceCounting
//  Model the lifetime of objects and their relationships.
//  Created by Andy Fang on 07/02/2024.
//

import Foundation

class Person {
    let name: String

    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil


/* Strong Reference Cycles Between Class Instances */
class PersonV1 {
    let name: String
    var apartment: Apartment?

    init(name: String) { self.name = name }
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    var tenant: PersonV1?

    init(unit: String) { self.unit = unit }
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: PersonV1?
var unit4A: Apartment?

john = PersonV1(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil


/* Resolving Strong Reference Cycles Between Class Instances */
class PersonV2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class ApartmentV1 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: PersonV2?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john1: PersonV2?
var unit4A1: ApartmentV1?
john1 = PersonV2(name: "John Appleseed")
unit4A1 = ApartmentV1(unit: "4A")
john1!.apartment = unit4A
unit4A1!.tenant = john1
john1 = nil
unit4A1 = nil

/* Unowned References */
class Customer {
    let name: String
    var card: CreditCard?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer

    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }

    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var john2: Customer?
john2 = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer: john2!)
john2 = nil

/* Unowned Optional References */
class Department {
    var name: String
    var courses: [Course]

    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?

    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")
let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)
intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

/* Unowned References and Implicitly Unwrapped Optional Properties */
class Country {
    let name: String
    var capitalCity: City!

    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
 
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")


/* Strong Reference Cycles for Closures */
class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil


/* Resolving Strong Reference Cycles for Closures */


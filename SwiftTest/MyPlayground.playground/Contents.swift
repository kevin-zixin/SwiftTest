//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


print("abc")


let language = "swift"

print("the lauguage name is \(language)")

/* comment like this
  this is still a comment */


let minValue = UInt8.min

let abv = 3.1415926


let a = 1.25e2
let b = 1.25e-2
b.hashValue


/*  type alias */
typealias AudioSample = UInt16

let c : AudioSample = 5


let http404Error = (404,"not found")
print(http404Error.0)


let (code, error) = http404Error
print("code is \(code)   and error is \(error)")


let letter = (a,b,"c")
let (first,_,_)=letter
print("first is ",first)


print(http404Error.0)


let httpError = (code:404,des:"not found")

print(httpError.code)


let possibleNum = "1234567"
let convertedNum = Int(possibleNum)

if convertedNum != nil {
    print("has value")
}

if let optionNum = Int(possibleNum){
    print("has num",optionNum)
}else{
    print("no num")
}

if let firstnumber = Int("a"), secondnumber = Int("6") where firstnumber < secondnumber {
    print("\(firstnumber) < \(secondnumber)")
}else{
    print("no")
}


func canThrowAnError() throws {
    
}


do {
    try canThrowAnError()
} catch {
    
}

let age = 3 /*age = -3 */
assert(age >= 0, "age can not less than 0")

//8%2.5
//8%(-2.5)
var h = 0
h+=1
let m=h


(3,"apple") < (3,"bird")

(3,"aec") > (3,"adc")


let q=99,w=100
var e = 0

let r = (q > w ? 59:20)


let defaultColorName = "red"
var userDefinedColorName: String?

var colorNameToUse = userDefinedColorName ?? defaultColorName


var welcome = "hello"
welcome.insert("b", at: welcome.endIndex)
//welcome.removeRange(welcome.endIndex.advancedBy(n: -1)..<welcome.endIndex)


//var someInts = [Int] ()
var someInts : [Int] = []

someInts.append(1)
someInts.append(2)

//var threeDoubles = [Double](count: 3, repeatedValue: 0.0)

var airports : [String : String] = [:]
var anotherAirports  = [String:String]()
if anotherAirports.isEmpty{
    print("empty")
}
anotherAirports["abc"] = "cde"
anotherAirports["bcd"] = "def"
anotherAirports



for (name , valuename) in anotherAirports{
    print("\(name)+\(valuename)")
    
    switch name {
        case "abc":
            print("1");
        default :
            print("2")
    }
    
}

let somePoint = (1,1)
switch somePoint {
    case (0,0):
        print("1")
default:
    print("2")
    
}


let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}


func firstFunc(firstParameter : Int, secondParameter : Int) -> (a: Int , b: Int , c:Int) {
    
    return (firstParameter,secondParameter,firstParameter+secondParameter)
}


firstFunc(firstParameter: 1, secondParameter: 2)


func arithmeticMean(numbers: Double...) -> Double{
    var total :Double = 0
    for number in numbers {
        total += number
    }
    
    return total/Double(numbers.count)
}


func stepForward(input:Int) -> Int {
    return input+1
}

func stepBackward(input:Int) -> Int {
    return input-1
}


func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveToZero = chooseStepFunction(backwards: currentValue>0)

moveToZero(currentValue)


func chooseStepFunction2(backwards : Bool) -> (Int)->Int {
    func stepForward(input:Int) -> Int {
        return input+1
    }
    
    func stepBackward(input:Int) -> Int {
        return input-1
    }

    return backwards ? stepBackward : stepForward
}


let goToZero = chooseStepFunction2(backwards: currentValue>0)

goToZero(currentValue)

var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1:String,_s2:String) -> Bool {
   return s1>_s2
}

//
//names.sort(backwards)
//
//names.sort(<)

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var output = ""
    var number = number
    while number>0{
        output = digitNames[number%10]! + output
        number /= 10
    }
    
    return output
}



enum CompassPoint {
    case North
    case South
    case East
    case West
}


enum ControlCharacter : Character {
    case Tab = "\t"
}






//////////////
class Vehicle {
var currentSpeed = 0.0
var description: String {
    return "traveling at \(currentSpeed) miles per hour"
}
func makeNoise() {
    // do nothing - an arbitrary vehicle doesn't necessarily make a noise
}
}



let someVehicle = Vehicle()

print(someVehicle.description)


someVehicle.currentSpeed = 100.8
print(someVehicle.description)





























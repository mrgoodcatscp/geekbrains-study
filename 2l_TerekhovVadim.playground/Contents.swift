import UIKit

//Проверка делимости
//(задания №1 и №2 в одном)
func doesItRemainder (dividend: Int, divisor: Int = 2) -> Void {
    var isRemainder:Bool
    if (dividend % divisor == 0) {
        isRemainder = false
    } else {
        isRemainder = true
    }
    switch divisor {
    case 2 where isRemainder == true:
        print ("\(dividend) - нечётное число.")
    case 2 where isRemainder == false:
        print ("\(dividend) - чётное число.")
    case _ where isRemainder == false:
        print ("\(dividend) делится нацело на \(divisor).")
    default:
        print ("\(dividend) не делится нацело на \(divisor).")
    }
}
//При не указании divisor выведет чётное/нечётное
doesItRemainder(dividend: 123456, divisor: 3)


//Массив из 100 чисел
var hNumArray = [Int] (1...100)
for elementEven in stride (from:2, to:hNumArray.count + 1, by: 2) {
    hNumArray.remove(at: (hNumArray.firstIndex(of: elementEven)!))
}
for elementThree in hNumArray where elementThree % 3 == 0 {
    hNumArray.remove(at: (hNumArray.firstIndex(of: elementThree)!))
}
print("В массиве остались следующие элементы:")
hNumArray.forEach({print($0)})

//Ряд Фибоначчи
func fibonacciArray(_ elementsCount:Int) -> [Double] {
    var fibArr: [Double] = [1, 1]
    for member in 2...elementsCount {
        fibArr.append(fibArr[member - 1] + fibArr[member - 2])
    }
    return fibArr
}
let outputArray = fibonacciArray(100)
outputArray.forEach({print($0)})

//Простые числа
var primeNumArray = [Int] (2...1000)
var startPosition:Int = 2
while startPosition < primeNumArray.count {
    for remElement in primeNumArray where remElement % startPosition == 0 {
        if remElement == startPosition {
            continue
        } else {
            primeNumArray.remove(at: (primeNumArray.firstIndex(of: remElement)!))
        }
    }
    startPosition += 1
}
primeNumArray.forEach({print($0)})
// Честно говоря, немного недопонял метод, описанный в задании, хотя сам принцип решета Эратосфена ясен. Надеюсь, такое не возрбраняется :)
// Насколько хорошим будет быстродействие, тоже затрудняюсь предположить, потому что не знаю, как выглядит каноничный вариант.

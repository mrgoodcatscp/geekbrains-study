import UIKit

//Квадратное уравнение ax^2+bx+c
let a:Double = 1
let b:Double = -6
let c:Double = 9
let D:Double = pow(b, 2) - 4 * a * c
if D < 0 {
    print("Действительных корней нет")
} else {
    let x1:Double = -b + sqrt(D) / 2 * a
    let x2:Double = -b - sqrt(D) / 2 * a
    if x1 == x2 {
        print("Единственный корень: \(x1)")
    } else {
        print("Первый корень: \(x1)")
        print("Второй корень: \(x2)")
    }
}

//Теорема Пифагора
let leg1:Double = 3
let leg2:Double = 4
let hyp:Double = sqrt(pow(leg1, 2) + pow(leg2, 2))
let per:Double = leg1 + leg2 + hyp
let area:Double = leg1 * leg2 / 2
print("Треугольник с катетами \(leg1) и \(leg2)")
print("Площадь: \(area)")
print("Периметр: \(per)")
print("Гипотенуза: \(hyp)")

//Вклад с капитализацией и без
let sumStart:Double = 100000
let proc:Double = 6
let depTime:Double = 5
let profitCap:Double = sumStart * pow((1 + (proc/100)/12), 12 * depTime)
let profitSimple:Double = sumStart + ((sumStart * (proc / 100)) * depTime)
print("Сумма вклада с капитализацией процентов за \(depTime) лет при ставке \(proc)% годовых составит: \(profitCap)")
print("Сумма обычного вклада за \(depTime) лет при ставке \(proc)% годовых составит: \(profitSimple)")

import UIKit

struct Giants {
    let brand: String
    let country: String
    let released: Double
}

extension Giants: CustomStringConvertible {
    var description : String {
        return """
        
        Бренд: \(self.brand)
        Страна: \(self.country)
        Выпущено: \(self.released) млн. автомобилей
        """
    }
}

//Очередь подразумевает FIFO
struct Queue<Type> {

    var items = [Type]()
    
    mutating func inter(_ item:Type) {
        items.append(item)
    }
    mutating func outer() -> Type {
        return items.removeFirst()
    }
    
    func filtered(condition:(Type) -> Bool) -> [Type] {
        var result = [Type]()
        for i in items {
            if condition(i) {
                result.append(i)
            }
        }
        return result
    }
    
    subscript(index: Int) -> Type? {
        if index < items.count && index >= 0 {
            return items[index]
        } else {
            print ("Всего \(items.count) записей")
            return nil
        }
    }
    
}

var greats = Queue<Giants>()
greats.inter(.init(brand: "Volkswagen AG", country: "Германия", released: 11.0))
greats.inter(.init(brand: "Daimler AG", country: "Германия", released: 2.3))
greats.inter(.init(brand: "BMW", country: "Германия", released: 2.53))
greats.inter(.init(brand: "Fiat-Chrysler", country: "Италия", released: 2.3))
greats.inter(.init(brand: "Renault-Nissan-Mitsubishi", country: "Франция", released: 8.46))
greats.inter(.init(brand: "GMC", country: "США", released: 6.21))
greats.inter(.init(brand: "Ford", country: "США", released: 5.62))
greats.inter(.init(brand: "Hyundai-Kia", country: "Южная Корея", released: 7.1))
greats.inter(.init(brand: "Suzuki", country: "Япония", released: 3.1))
greats.inter(.init(brand: "Toyota", country: "Япония", released: 10.57))
greats.inter(.init(brand: "Honda", country: "Япония", released: 5.31))
greats.inter(.init(brand: "PSA", country: "Франция", released: 2.42))

print("=== Самые высокопроизводительные концерны: ===")
let muchReleased = greats.filtered(condition: {$0.released > 5.0})
for top in muchReleased.sorted(by: {$0.released > $1.released}) {
    print(top)
}
print("=================================")

print("=== Немецкие концерны: ===")
let deutchAutoconcerns = greats.filtered(condition: {$0.country == "Германия"})
for top in deutchAutoconcerns.sorted(by: {$0.brand < $1.brand}) {
    print(top)
}
print("=================================")

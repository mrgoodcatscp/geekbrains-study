import UIKit

enum brands {
    case BMW
    case Audi
    case Mercedes
    case Scania
    case KamAZ
    case Freightliner
}

enum transmissionType:String {
    case auto = "АКПП"
    case manual = "МКПП"
}

enum stages {
    case Stage1
    case Stage2
    case Stage3
}

struct casualCar {
    let brand:brands
    let manufactureYear:Int16
    let engineSize:Double
    var enginePower:Int16 {
        didSet {
            print ("Мощность двигателя выросла до", self.enginePower, "кВт")
        }
    }
    let transmission:transmissionType
    var maxSpeed:Double {
        didSet {
            print ("Максимальная скорость выросла до", self.maxSpeed, "км/ч")
        }
    }
    var isWindowOpen:Bool = false
    var isEngineStarted:Bool = false {
        willSet {
            if isEngineStarted == false {
                print ("Заводим двигатель...")
            } else {
                print ("Глушим двигатель...")
            }
        }
    }
    var isEngineTuned:Bool = false
    mutating func turnKey() {
        self.isEngineStarted = !self.isEngineStarted
    }
    mutating func engineStaging(level:stages) {
        print ("Производим тюнинг двигателя...")
        self.isEngineTuned = true
        func enlargeDrive (power:Int16, speedPercent:Double) {
            self.enginePower += power
            self.maxSpeed += self.maxSpeed * (speedPercent/100)
        }
        switch level {
        case .Stage1:
            enlargeDrive(power: 20, speedPercent: 15)
        case .Stage2:
            enlargeDrive(power: 35, speedPercent: 25)
        case .Stage3:
            enlargeDrive(power: 50, speedPercent: 35)
        }
    }
    mutating func pressWindowButton() {
        self.isWindowOpen = !self.isWindowOpen
    }
    func description() {
        print ("====================================")
        print ("Марка авто:", self.brand)
        print ("Год выпуска:", self.manufactureYear)
        print ("Объём двигателя:", self.engineSize, "л.")
        print ("Мощность двигателя:", self.enginePower, "кВт")
        print ("Коробка передач:", self.transmission.rawValue)
        print ("Максимальная скорость:", self.maxSpeed, "км/ч")
        print ("====================================")
    }
    func status() {
        if self.isWindowOpen == true {
            print ("Окна открыты")
        } else {
            print ("Окна закрыты")
        }
        if self.isEngineTuned == true {
            print ("Для двигателя был выполнен тюнинг")
        } else {
            print ("Двигатель в стоковом состоянии")
        }
        if isEngineStarted == true {
            print ("Двигатель запущен")
        } else {
            print ("Двигатель заглушен")
        }
    }
}

struct truckCar {
    let brand:brands
    let manufactureYear:Int16
    let engineSize:Double
    var enginePower:Int16
    let transmission:transmissionType
    let carryingCapacity:Double
    var usedCapacity:Double = 0 {
        didSet {
            print ("Загружено \(Int16(round(self.usedCapacity/self.carryingCapacity * 100)))% от общей вместимости")
        }
    }
    var isWindowOpen:Bool = false
    var isEngineStarted:Bool = false {
        willSet {
            if isEngineStarted == false {
                print ("Заводим двигатель...")
            } else {
                print ("Глушим двигатель...")
            }
        }
    }
    mutating func loadCargo(value:Double) {
        switch value {
        case _ where value <= 0:
            print ("Погрузка не требуется")
        case _ where value > self.carryingCapacity || (value + self.usedCapacity) > self.carryingCapacity:
            print ("Нельзя превысить лимит грузоподъёмности в \(self.carryingCapacity) кг.", "Занято: \(self.usedCapacity) кг.", "Доступно: \(self.carryingCapacity - self.usedCapacity) кг.")
        case _ where (value + self.usedCapacity) > self.carryingCapacity:
            print ("")
        default:
            print ("Выполняем погрузку \(value) кг. груза")
            self.usedCapacity += value
        }
    }
    mutating func turnKey() {
        self.isEngineStarted = !self.isEngineStarted
    }
    func description() {
        print ("====================================")
        print ("Марка авто:", self.brand)
        print ("Год выпуска:", self.manufactureYear)
        print ("Объём двигателя:", self.engineSize, "л.")
        print ("Мощность двигателя:", self.enginePower, "кВт")
        print ("Коробка передач:", self.transmission.rawValue)
        print ("Грузоподъёмность:", self.carryingCapacity, "кг.")
        print ("====================================")
    }
    func status() {
        print ("В прицеп загружено \(self.usedCapacity) кг. груза.")
        if isEngineStarted == true {
            print ("Двигатель запущен")
        } else {
            print ("Двигатель заглушен")
        }
        if self.isWindowOpen == true {
            print ("Окна открыты")
        } else {
            print ("Окна закрыты")
        }
    }
}

var bmwCar = casualCar (brand: .BMW, manufactureYear: 2016, engineSize: 3.0, enginePower: 183, transmission: .auto, maxSpeed: 220)
bmwCar.engineStaging(level: .Stage3)
bmwCar.turnKey()
bmwCar.pressWindowButton()
bmwCar.description()
bmwCar.status()
var truck = truckCar(brand: .Scania, manufactureYear: 1999, engineSize: 11.7, enginePower: 294, transmission: .manual, carryingCapacity: 19000, usedCapacity: 700)
truck.loadCargo(value: 17400)
truck.description()
truck.status()

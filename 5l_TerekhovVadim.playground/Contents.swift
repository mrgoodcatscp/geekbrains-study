import UIKit

enum brands {
    case BMW
    case Audi
    case Mercedes
    case Volkswagen
    case Porsche
    case Volvo
    case Scania
    case MAN
    case KamAZ
    case Freightliner
    case Mack
}

enum transmissionType: String {
    case HMT = "АКПП гидромеханическая"
    case CVT = "АКПП вариаторная"
    case AMT = "АКПП роботизированная"
    case MT = "МКПП"
    case SMT = "МКПП секвентальная"
}

enum engineType: String {
    case petrol = "Бензиновый"
    case diesel = "Дизельный"
    case hybrid = "Гибридный"
    case electro = "Электрический"
    case gas = "Газовый"
}

enum stages {
    case Stage1
    case Stage2
    case Stage3
}

protocol Automobile {
    var brand: brands {get}
    var manufactureYear: Int16 {get}
    var transmission: transmissionType {get}
    var engine: engineType {get}
    var engineSize: Double {get}
    var enginePower: Double {get set}
    var isEngineStarted: Bool {get set}
    var isWindowsOpen: Bool {get set}
}

class sportcar: Automobile {
    var brand: brands
    var manufactureYear: Int16
    var engine: engineType
    var engineSize: Double
    var enginePower: Double
    var transmission: transmissionType
    var isEngineStarted: Bool = false
    var isWindowsOpen: Bool = false

    //Уникальные свойства для спорткара
    var isEngineTuned: Bool = false
    var maxSpeed: Double = 250.0 {
        didSet {
            print ("Максимальная скорость выросла до", self.maxSpeed, "км/ч")
        }
    }
    
    init (brand: brands, year: Int16, engine: engineType, engineSize: Double, power: Double, transmission: transmissionType) {
        self.brand = brand
        self.manufactureYear = year
        self.engine = engine
        self.engineSize = engineSize
        self.transmission = transmission
        self.enginePower = power
    }
}

class truck: Automobile {
    var brand: brands
    var manufactureYear: Int16
    var engine: engineType
    var engineSize: Double
    var enginePower: Double
    var transmission: transmissionType
    var isEngineStarted: Bool = false
    var isWindowsOpen: Bool = false
    
    //Уникальные свойства для грузовика
    var carryingCapacity:Double = 0
    var usedCapacity:Double = 0 {
        didSet {
            print ("Загружено \(Int16(round(self.usedCapacity/self.carryingCapacity * 100)))% от общей вместимости")
        }
    }
    var isTrailerBehind:Bool = false
    
    init (brand: brands, year: Int16, engine: engineType, engineSize: Double, power: Double, transmission: transmissionType) {
        self.brand = brand
        self.manufactureYear = year
        self.engine = engine
        self.enginePower = power
        self.engineSize = engineSize
        self.transmission = transmission
    }
}

extension Automobile {

    mutating func turnKey () {
        self.isEngineStarted = !self.isEngineStarted
        if (isEngineStarted) {
            print ("Запускаем двигатель")
        } else {
            print ("Глушим двигатель")
        }
    }
}

extension Automobile {

    mutating func pressWindowButton () {
        self.isWindowsOpen = !self.isWindowsOpen
        if (isWindowsOpen) {
            print ("Открываем окна")
        } else {
            print ("Закрываем окна")
        }
    }
    
}

extension sportcar {
    func takeAStage (stage: stages) {
        func enlargeDrive (power:Double, speedPercent:Double) {
            self.enginePower += power
            self.maxSpeed += self.maxSpeed * (speedPercent/100)
        }
        switch stage {
            case .Stage1:
                enlargeDrive(power: 20, speedPercent: 15)
            case .Stage2:
                enlargeDrive(power: 35, speedPercent: 25)
            case .Stage3:
                enlargeDrive(power: 50, speedPercent: 35)
        }
    }
}

extension truck {
    func takeATrailer (capacity: Double) {
            print ("Устанавливаем прицеп грузоподъёмностью \(capacity) кг...")
            self.carryingCapacity = capacity
    }
    func loadCargo(value:Double) {
        if (isTrailerBehind == true) {
            print("Прежде нужно установить прицеп")
            return
        } else {
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
    }
}

extension truck: CustomStringConvertible {
    var description: String {
        return """

        ==== КРАТКАЯ СПРАВКА ===============
        ====================================
        Марка грузовика: \(self.brand)
        Год выпуска: \(self.manufactureYear)
        Объём двигателя: \(self.engineSize)
        Мощность двигателя: \(self.enginePower)
        Коробка передач: \(self.transmission.rawValue)
        Грузоподъёмность: \(self.carryingCapacity)
        
        Прицеп \(self.isTrailerBehind ? "присоединён" : "не присоединён")
        Погружено: \(self.usedCapacity) кг. груза
        Двигатель \(self.isEngineStarted ? "запущен" : "не запущен")
        Окна \(self.isWindowsOpen ? "открыты" : "закрыты")
        ====================================

        """
    }
}

extension sportcar: CustomStringConvertible {
    var description: String {
        return """

        ==== КРАТКАЯ СПРАВКА ===============
        ====================================
        Марка грузовика: \(self.brand)
        Год выпуска: \(self.manufactureYear)
        Объём двигателя: \(self.engineSize)
        Мощность двигателя: \(self.enginePower)
        Коробка передач: \(self.transmission.rawValue)

        \(self.isEngineTuned ? "Выполнен тюнинг двигателя" : "Двигатель в стоковом состоянии")
        Максимальная скорость: \(self.maxSpeed)
        Двигатель \(self.isEngineStarted ? "запущен" : "не запущен")
        Окна \(self.isWindowsOpen ? "открыты" : "закрыты")
        ====================================

        """
    }
}



var sportPorsche = sportcar (brand: .Volkswagen, year: 2015, engine: .petrol, engineSize: 2.5, power: 200.0, transmission: .SMT)
var truckMAN = truck (brand: .MAN, year: 1995, engine: .diesel, engineSize: 18.0, power: 270.0, transmission: .MT)

sportPorsche.takeAStage(stage: .Stage1)
sportPorsche.turnKey()
sportPorsche.pressWindowButton()
print(sportPorsche.description)

truckMAN.takeATrailer(capacity: 40000.0)
truckMAN.loadCargo(value: 36885.5)
truckMAN.turnKey()
truckMAN.pressWindowButton()
print(truckMAN.description)

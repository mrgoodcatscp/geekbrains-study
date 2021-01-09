import UIKit

class Automobile {
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
    
    let manufactureYear:Int16
    let engineSize:Double
    var enginePower:Int16
    var isWindowOpen:Bool = false {
        willSet {
            if self.isWindowOpen == false {
                print ("Открываем окна...")
            } else {
                print ("Закрываем окна...")
            }
        }
    }
    var isEngineStarted:Bool = false {
        willSet {
            if isEngineStarted == false {
                print ("Заводим двигатель...")
            } else {
                print ("Глушим двигатель...")
            }
        }
    }
    
    func turnKey() {
        self.isEngineStarted = !self.isEngineStarted
    }
    
    func pressWindowButton() {
        self.isWindowOpen = !self.isWindowOpen
    }
    
    init(brand: brands, transmission: transmissionType, year: Int16, engineSize: Double, power: Int16) {
        self.manufactureYear = year
        self.engineSize = engineSize
        self.enginePower = power
    }
}

class truck: Automobile {
    var carryingCapacity:Double = 0.0 {
        didSet {
            print("Установлен прицеп вместимостью \(self.carryingCapacity)")
        }
    }
    var isTrailerBehind:Bool = false
    var usedCapacity:Double = 0 {
        didSet {
            print ("Загружено \(Int16(round(self.usedCapacity/self.carryingCapacity * 100)))% от общей вместимости")
        }
    }
    func takeATrailer (capacity: Double) {
        print ("Устанавливаем прицеп...")
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

class sportcar: Automobile {
    enum stages {
        case Stage1
        case Stage2
        case Stage3
    }
    
    var maxSpeed:Double = 250.0 {
        didSet {
            print ("Максимальная скорость выросла до", self.maxSpeed, "км/ч")
        }
    }
    var isEngineTuned:Bool = false
    func engineStaging(level:stages) {
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
}

var sportAudi = sportcar(brand: .Audi, transmission: .auto, year: 2017, engineSize: 2.0, power: 170)
sportAudi.pressWindowButton()
sportAudi.turnKey()
sportAudi.engineStaging(level: .Stage2)
var truckKamaz = truck(brand: .KamAZ, transmission: .manual, year: 2010, engineSize: 16, power: 330)
truckKamaz.takeATrailer(capacity: 40000.0)
truckKamaz.loadCargo(value: 35000.0)
truckKamaz.turnKey()
truckKamaz.pressWindowButton()

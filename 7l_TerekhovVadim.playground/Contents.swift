import UIKit

enum releasingError: Error {
    case unableToPack
    case boxCrowded
    case powerDown
}

class DetailsFactory {
    let boxCapacity: Int = 27
    var boxCurrent: Int = 0
    var packedBoxCount: Int = 0
    let energyPerDetail: Int = 2
    let energyOfFactory: Int = 30
    
    func release(count: Int) -> (Int?, Error?) {
        guard boxCurrent + count <= boxCapacity else {
            return (nil, releasingError.boxCrowded)
        }
        guard count * energyPerDetail <= energyOfFactory else {
            return (nil, releasingError.powerDown)
        }
        boxCurrent += count
        print ("Отправляем в коробку \(count) деталей. Сейчас заполнено \(boxCurrent)")
        return (boxCapacity - boxCurrent, nil)
    }
    
    func packBox() throws {
        guard boxCurrent == boxCapacity else {
            throw releasingError.unableToPack
        }
        packedBoxCount += 1
        boxCurrent = 0
        print("Упаковано коробок: \(packedBoxCount)")
    }
}

var rel = DetailsFactory()
rel.release(count: 10)
rel.release(count: 14)
rel.release(count: 3)
do {
    try rel.packBox()
} catch let err as releasingError {
    print(err)
}

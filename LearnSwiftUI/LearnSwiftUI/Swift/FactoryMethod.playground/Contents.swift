import Foundation

class FruitItem {
    
    enum FruitType {
        case apple
        case banana
        case orange
        
        var fruitPrice: Double {
            switch self {
            case .apple:
                return 10.0
            case .banana:
                return 5.0
            case .orange:
                return 8.0
            }
        }
    }
    
    var fruitType: FruitType
    var count: Int
    var price: Double = 0.0
    
    private init(fruitType: FruitType, count: Int) {
        self.fruitType = fruitType
        self.count = count
        self.price = fruitType.fruitPrice
    }
    
    // Factory method to create FruitItem.
    static func create(fruitType: FruitType, count: Int) -> FruitItem? {
        if count <= 0 {
            print("Failed to create FruitItem: count must be greater than 0.")
            return nil
        }
        return FruitItem(fruitType: fruitType, count: count)
    }
}

//if let appleBox = FruitItem.create(fruitType: .apple, count: 9) {
//    print("One apple has a price of \(appleBox.fruitType.fruitPrice) dollars.")
//    print("An apple box with \(appleBox.count) and total price of \(appleBox.price * Double(appleBox.count)) dollars.")
//}

/// ===================================

//class Square: Shape {}
//class Circle: Shape {}
//
//class Shape {
//    enum ShapeType {
//        case square
//        case circle
//    }
//    
//    static func create(shapeType: ShapeType) -> Shape? {
//        switch shapeType {
//        case .square:
//            return Square()
//        case .circle:
//            return Circle()
//        }
//    }
//}

//let square: Shape? = Shape.create(shapeType: .square)
//let circle: Shape? = Shape.create(shapeType: .circle)

/// ===================================

@MainActor
class User {
    var username: String
    var email: String?
    
    private init(username: String, email: String?) {
        self.username = username
        self.email = email
    }
    
    private static var cache: [String: User] = [:]
    
    static func create(_ username: String,_ email: String?) -> User? {
        if let existingUserInstance = cache[username] {
            return existingUserInstance
        }
        let newUserInstance = User(username: username, email: email)
        cache[username] = newUserInstance
        return newUserInstance
    }
}

let user1 = User.create("alice", "alice@example.com")
let user2 = User.create("alice", "alice@example.com")
let user3 = User.create("hao", "haonguyen@gmail.com")

print(user1 === user2)
print(user2 === user3)

import UIKit
import Foundation

// MARK: - BASIC
struct User: Codable {
    let name: String
    let age: Int
    let email: String?
}

func encodeUserToJSON() -> String? {
    let user = User(name: "John", age: 30, email: "john@example.com")
    do {
        let jsonData = try JSONEncoder().encode(user)
        return String(data: jsonData, encoding: .utf8)
    } catch {
        debugPrint(error.localizedDescription)
        return nil
    }
}

func encodeUserToData() -> Data? {
    let user = User(name: "John", age: 30, email: "john@example.com")
    do {
        return try JSONEncoder().encode(user)
    } catch {
        debugPrint(error.localizedDescription)
        return nil
    }
}

func decodeDataToUser() -> User? {
    let jsonString = """
                    {
                        "name":"Bob", "age":25, "email":"bob@example.com"
                    }
                    """
    guard let data = jsonString.data(using: .utf8) else {
        return nil
    }
    
    do {
        return try JSONDecoder().decode(User.self, from: data)
    } catch {
        debugPrint(error.localizedDescription)
        return nil
    }
}

//debugPrint("decodeDataToUser \(String(describing: decodeDataToUser()))")

//-------------------------//-------------------------//

// MARK: - Customization with CodingKeys
let productJsonString = """
{
    "name": "iPhone", "id": 1
} 
"""

struct Product: Decodable {
    let productID: Int
    let productName: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: ProductKeys.self)
        self.productID = try container.decode(Int.self, forKey: .productID)
        self.productName = try container.decode(String.self, forKey: .productName)
    }
    
    private enum ProductKeys: String, CodingKey {
        case productID = "id"
        case productName = "name"
    }
}

func decodeProductWithCustomKeys(_ jsonString: String) -> Product? {
    guard let data = jsonString.data(using: .utf8) else {
        return nil
    }
    
    do {
        return try JSONDecoder().decode(Product.self, from: data)
    } catch {
        debugPrint(error.localizedDescription)
        return nil
    }
}

//debugPrint("\(String(describing: decodeProductWithCustomKeys(productJsonString)))")

//-------------------------//-------------------------//
//MARK: - Json Tree
/// container and nestedContainer
let userInfoJsonString = """
{
    "user_info": {
        "full_name": "Alice",
        "age_in_years": 30
    }
} 
"""

struct UserInfo: Decodable {
    let name: String
    let age: Int
    
    private enum MainKeys: String, CodingKey {
        case userInfo = "user_info"
    }
    
    private enum NestedKeys: String, CodingKey {
        case name = "full_name"
        case age = "age_in_years"
    }
    
    init(from decoder: any Decoder) throws {
        // 1. Get the main container
        let mainContainer = try decoder.container(keyedBy: MainKeys.self)
        // 2. Get the nested container using the key 'user_info'
        let nestedContainer = try mainContainer.nestedContainer(keyedBy: NestedKeys.self, forKey: .userInfo)
        // 3. Decode the attributes from the nested container.
        self.name = try nestedContainer.decode(String.self, forKey: .name)
        self.age = try nestedContainer.decode(Int.self, forKey: .age)
    }
}

func decodeFrom<T: Decodable>(jsonString: String) -> T? {
    
    guard let data = jsonString.data(using: .utf8) else {
        return nil
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        // 1. Attempt to cast the error to DecodingError
        guard let decodingError = error as? DecodingError else {
            // Handle other general errors (e.g., IO errors, etc.)
            debugPrint("Error other than DecodingError: \(error.localizedDescription)")
            return nil
        }
        
        // 2. Use a switch statement to specifically analyze the DecodingError
        switch decodingError {
        case .dataCorrupted(let context):
            // Error to catch: corrupted data (as in the case of '12345aa' instead of a number)
            debugPrint("🚨 DATA CORRUPTED ERROR:")
            debugPrint("Description: \(context.debugDescription)")
            
        case .keyNotFound(let key, let context):
            // Missing key error in JSON
            debugPrint("⚠️ KEY NOT FOUND ERROR:")
            debugPrint("Missing key: \(key.stringValue)")
            debugPrint("Path: \(context.codingPath)")
            
        case .typeMismatch(let type, let context):
            // Data type mismatch error (e.g., expecting String but received Array)
            debugPrint("❌ TYPE MISMATCH ERROR:")
            debugPrint("Expected type: \(type)")
            debugPrint("Path: \(context.codingPath)")
            
        case .valueNotFound(let type, let context):
            // Value not found error (e.g., receiving 'null' for a non-Optional property)
            debugPrint("❓ VALUE NOT FOUND ERROR:")
            debugPrint("Missing type: \(type)")
            debugPrint("Path: \(context.codingPath)")
            
        @unknown default:
            // Handle new DecodingError errors in future Swift versions
            debugPrint("Unknown DecodingError: \(error.localizedDescription)")
        }
        
        return nil
    }
}

//let userInfo: UserInfo? = decodeFrom(jsonString: userInfoJsonString)
//debugPrint("\(String(describing: userInfo))")

//-------------------------//-------------------------//
//MARK: - Hard Level

let profileJsonString = """
{
    "user_profile": {
        "person_details": {
            "full_name": "Bob Nguyễn",
            "age_in_years": 28,
            "is_active": true
        },
        "contact": {
            "email": "bob.nguyen@example.com",
            "phone": "0901234567"
        },
        "addresses": [
            {
                "street": "123 Main St",
                "city": "Hanoi"
            },
            {
                "street": "45 Lê Lợi",
                "city": "Ho Chi Minh"
            }
        ]
    }
}
"""

struct Profile: Decodable {
    let details: Details
    let contact: Contact
    let addresses: [Address]
    
    private enum MainKeys: String, CodingKey {
        case profile = "user_profile"
    }
    
    private enum NestedKeys: String, CodingKey {
        case personDetails = "person_details"
        case contact
        case addresses
    }
    
    init(from decoder: any Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: MainKeys.self)
        let nestedContainer = try mainContainer.nestedContainer(keyedBy: NestedKeys.self, forKey: .profile)
        self.details = try nestedContainer.decode(Details.self, forKey: .personDetails)
        self.contact = try nestedContainer.decode(Contact.self, forKey: .contact)
        self.addresses = try nestedContainer.decode([Address].self, forKey: .addresses)
    }
}

struct Details: Decodable {
    let fullName: String
    let age: Int
    let isActive: Bool
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case ageInYears = "age_in_years"
        case isActive = "is_active"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.age = try container.decode(Int.self, forKey: .ageInYears)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
    }
    
}

struct Contact: Decodable {
    let email: String
    let phone: String
    
    private enum CodingKeys: String, CodingKey {
        case email
        case phone
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
    }
}

struct Address: Decodable {
    let street: String
    let city: String
    
    private enum CodingKeys: String, CodingKey {
        case street
        case city
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.city = try container.decode(String.self, forKey: .city)
    }
}

//let profile: Profile? = decodeFrom(jsonString: profileJsonString)
//debugPrint("\(String(describing: profile))")

//-------------------------//-------------------------//

// MARK: - Custom Type Conversion
let productJsonStringTest = """
{
    "product_name": "Laptop Pro",
    "product_id": "12345aa", 
    "price_string": "999aa"
}
"""
struct ProductInStore: Decodable {
    let productName: String
    let productId: Int
    let price: Double
    
    private enum CodingKes: String, CodingKey {
        case productName = "product_name"
        case productId = "product_id"
        case priceString = "price_string"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKes.self)
        self.productName = try container.decode(String.self, forKey: .productName)
        
        let id: String = try container.decode(String.self, forKey: .productId)
        let price: String = try container.decode(String.self, forKey: .priceString)
        
        guard let productId = Int(id) else {
            throw DecodingError.dataCorruptedError(forKey: .productId, in: container, debugDescription: "Invalid product ID format")
        }
        self.productId = productId
        
        guard let priceDouble = Double(price) else {
            throw DecodingError.dataCorruptedError(forKey: .priceString, in: container, debugDescription: "Invalid price format")
        }
        self.price = priceDouble
    }
}

let productInStore: ProductInStore? = decodeFrom(jsonString: productJsonStringTest)
debugPrint("\(String(describing: productInStore))")

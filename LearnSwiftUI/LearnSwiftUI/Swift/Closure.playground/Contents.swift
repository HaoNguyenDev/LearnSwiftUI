import UIKit
import Foundation

//MARK: Closure
/*
 Closure trong Swift là gì?
 * Closure trong Swift là một khối mã độc lập có thể được truyền và sử dụng lại trong code.
 Closure có thể nhận tham số, trả về giá trị, và có khả năng capture (giữ lại) các biến,
 hằng số từ phạm vi xung quanh nó.
 
 Closure trong Swift có thể được coi như hàm ẩn danh (anonymous function) vì nó không cần khai báo tên giống như function thông thường.
 
 So sánh với function:
 Không có tên, có thể gán với biến, hoặc truyền như tham số
 Có thể capture biến bên ngoài
 
 📌 Lợi ích của [weak self]
 ✅ Nếu self bị giải phóng, closure sẽ không giữ lại nó, tránh retain cycle.
 ✅ self trong closure sẽ thành nil nếu đối tượng đã bị xóa.
 
 Function
 Được gọi trực tiếp theo tên
 Không thể capture biến bên ngoài trừ khi sử dụng @escaping
*/
/*
 { (parameters) -> ReturnType in
    // Code to execute
 }
 */
var myClosure1: (String) -> String
var myClosure2: (Int, Int) -> Bool
var myClousre3 = {
    return 10
}
myClosure1 = { (str) -> String in
    return str
}
print(myClosure1("Hello myClosure1"))

var myClosure3 : (Int, Int) -> Int = { (a,b) -> Int in
    return a+b
}

//MARK: Cách sử dụng Closure
//MARK: Truyền closure như một tham số vào hàm:

var congThucTinhTong2So: (Int, Int) -> String = { (a, b) -> String in
    return "\(a + b)"
}

func tong(_ a: Int, _ b: Int, operation: (Int, Int) -> String) -> String {
    return "Tong la: \(operation(a, b))"
}

let tinhTong = tong(10, 20, operation: congThucTinhTong2So)



//MARK: Sử dụng closure với các hàm có sẵn như map, filter, reduce:
let numbers: [Int?] = [1, 2, nil, 3, 4, 5, nil, 6, 8, 10, nil]

let closureSoChan:  (Int) -> Bool = { number in
    return number % 2 == 0
}

let compactMapNumber = numbers
    .compactMap { $0 } // Loai bỏ những phần từ bị nil
    .filter(closureSoChan) // Sau đó lấy số chẵn

let soChan = compactMapNumber.filter { $0 % 2 == 0 } // Lọc phần tử thỏa mãn điều kiện

let soChan2 = compactMapNumber.filter(closureSoChan) // Lọc phần tử thỏa mãn điều kiện closure

let tongCuaCac = compactMapNumber.reduce(0, +) // Gộp các phần tử thành một giá trị

let mapSo = compactMapNumber.map { $0 + 1 } // Biến đổi từng phần tử

let xapXepTangDan = compactMapNumber.sorted { $0 > $1 } // Sắp xếp mảng

compactMapNumber.forEach { print($0) } // Lặp qua từng phần tử

//MARK: Escaping Closure
//Closure có thể được lưu trữ và gọi sau này bằng @escaping:

var scheduledTasks: [(String) -> Void] = []

@MainActor func scheduleTask(task: @escaping (String) -> Void) {
    scheduledTasks.append(task)
}

// Thêm các công việc vào danh sách
scheduleTask { taskName in
    print("Chạy tác vụ: \(taskName)")
}

scheduleTask { taskName in
    print("Ghi log: \(taskName) đã hoàn thành")
}

// Khi đến thời gian thực hiện công việc
@MainActor func runScheduledTasks() {
    print("Thực thi tất cả các tác vụ:")
    for task in scheduledTasks {
        task("Backup dữ liệu")
    }
}

// Giả lập chạy tất cả công việc đã lên lịch
runScheduledTasks()



print("Closure Capture List có thể Capture biến từ phạm vi xung quanh nó")
// MARK: Closure Closure có thể Capture biến từ phạm vi xung quanh nó

@MainActor func increaseCounter(numberParam: Int) -> (Int) -> Int {
    // Clousure sẽ capture biến number để thực hiện cho lần tiếp theo
    var number = numberParam
    return { input in
        print("input: \(input)")
        number += input
        return number
    }
}

let numberIncreased = increaseCounter(numberParam: 1)
print(numberIncreased(1))
print(numberIncreased(1))
print(numberIncreased(1))
print(numberIncreased(3))

@MainActor func countUp() -> (Int) -> Int {
    var counter = 0
    return { increment in
        counter += increment
        return counter
    }
}

let countUp1 = countUp()
print(countUp1(1))
print(countUp1(1))
print(countUp1(1))

print("Trailing Closure")
//MARK: Trailing Closure:
// Cú pháp sẽ ngắn gọn hơn khi clousure là tham số cuối cùng của function
// Ví dụ như những API sort, filter
func doSomething(completion: (Bool) -> String) -> String {
    completion(true)
}

doSomething { isCompletion in
    print(isCompletion)
    return "Is completion: \(isCompletion)"
}


let timSoChan: (Int) -> Bool
timSoChan = { number in
    number % 2 == 0
}

let xapXepSoTangDan: (Int, Int) -> Bool
xapXepSoTangDan = { a, b in
    a < b
}

//xapXepSoTangDan = { $0 < $1 }

let soNgauNhien: [Int?]  = [nil, 11, 12, 15, nil, 18, 20, 0, nil, 2, 3, 4, nil, 5, 6, 7, 8, 9, 10]

let daySoUnwrap = soNgauNhien.compactMap { $0 }
let daySoChan1 = daySoUnwrap.filter(timSoChan)
let soTangDan = daySoChan1.sorted(by: xapXepSoTangDan)
let soTangDan2 = daySoUnwrap.sorted { $0 < $1 }
let compacMap = soNgauNhien.compactMap { $0 } // Loại bỏ nil

let inSo: (Int) -> Void = { number in
    print("\(number % 2 == 0 ? "Số chẵn \(number)" : "Số lẻ \(number)")")
}
daySoUnwrap.forEach(inSo)


import Foundation

let animals = ["dog", "pig", "cat", "ox", "cow", "cow", "cow", "owl"]
let uniqueAnimals = Array(Set(animals)).sorted()
print(uniqueAnimals)


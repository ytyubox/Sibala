import XCTest
import Foundation
class Sibala_ {
    internal init(input: String) {
        self.input = input
    }
    
    let input:String
    func getTwoString() -> [String] {
        input
            .components(separatedBy: "  ")
            .map{String($0)}
    }
    func getMaps(twoString: [String]) -> [Map] {
        twoString.map(paring(input:))
    }
    func paring(input: String) -> Map {
        //Amy:2 2 6 6
        let split = input.split(separator: ":").map{$0}
        let listStr = split[1]
        let list = listStr.split(separator: " ").compactMap{Int($0)}
       return Map(name: String(split[0]), dice: list)
    }
}



struct Map:Equatable {
    let name:String
    let dice: [Int]
}

enum SibalaCase {
    case oneSet
    case normal
    case none
}
final class SibalaTests: XCTestCase {
    func testCan() {
        let input = "Amy:2 2 6 6  Lin: 6 6 3 1"
        let sut = Sibala_(input: input)
        let twostring = sut.getTwoString()
        XCTAssertEqual(twostring, ["Amy:2 2 6 6",  "Lin: 6 6 3 1"])
        
        
        let maps:[Map] = [
            Map(name: "Amy", dice: [2,2,6,6]),
            Map(name: "Lin", dice: [6,6,3,1])
        ]
        XCTAssertEqual(sut.getMaps(twoString: twostring), maps)
    }
    func whichCase(dice: [Int]) -> SibalaCase {
        let set = Set(dice)
        if set.count == 1 {return .oneSet}
        if set.count == 4 {return .none}
        return .normal
    }
    func test() {
        let oneSetDice = [6,6,6,6]
        XCTAssertEqual(whichCase(dice: oneSetDice), .oneSet)
        
        let noneDice = [1,2,3,4]
        XCTAssertEqual(whichCase(dice: noneDice), .none)
        
        let normalDice1 = [1,2,6,6]
        XCTAssertEqual(whichCase(dice: normalDice1), .normal)
        let normalDice2 = [2,2,6,6]
        XCTAssertEqual(whichCase(dice: normalDice2), .normal)
    }
}

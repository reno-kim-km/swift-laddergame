//
//  main.swift
//  LadderGame
//
//  Created by Joon-ho Kil on 04/09/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

/// 사다리를 만들지 여부를 저장할 타입
enum LadderChecker:Int {
    case make = 1
    case notMake = 0
}


/// 사용자로부터 입력받는 함수
func inputFromUser () -> (Int, Int) {
    print("참여할 사람은 몇 명 인가요?")
    let optionalHuman = readLine()
    print("최대 사다리 높이는 몇 개인가요?")
    let optionalHeight = readLine()
    
    var human = 0
    var height = 0
    
    if let stringHuman = optionalHuman {
        human = Int(stringHuman) ?? 0
        human -= 1
    }

    if let stringHeight = optionalHeight {
        height = Int(stringHeight) ?? 0
    }
    
    return (human, height)
}

/// 사다리를 만들고 저장하는 함수
func ladderMake (_ input: (Int, Int)) -> [[String]] {
    var check:LadderChecker?
    let human = input.0
    let height = input.1
    var ladder : [[String]] = Array(repeating: Array(repeating: "",count:human ), count: height)
    
    for heightIndex in 0..<height {
        for humanIndex in 0..<human {
            check = LadderChecker(rawValue: Int.random(in: 0...1))
            
            if humanIndex>0 && ladder[heightIndex][humanIndex-1] == "-" {
                check = LadderChecker.notMake
            }
            
            switch check {
            case .make? :
                ladder[heightIndex][humanIndex] = "-"
            case .notMake? :
                ladder[heightIndex][humanIndex] = " "
            case .none:
                ladder[heightIndex][humanIndex] = " "
            }
        }
    }
    
    return ladder
}

/// 사다리를 출력하는 프로그램
func ladderPrint (_ ladder:[[String]]) -> () {
    let height = ladder.count
    let human = ladder[0].count
    
    for heightIndex in 0..<height {
        for humanIndex in 0..<human {
            print("|", terminator: "")
            print(ladder[heightIndex][humanIndex], terminator: "")
        }
        print("|")
    }
}

/// 사다리 게임 함수
func ladderGame() {
    var input = (0, 0)
    while input.0 < 1 && input.0 < 1 {
        input = inputFromUser()
        if input.0 < 1 || input.1 < 1 {
            print("참여할 사람과 최대 사다리 높이를 정확히 입력해주세요.")
        }
    }
    let ladder = ladderMake(input)
    ladderPrint(ladder)
}

ladderGame()


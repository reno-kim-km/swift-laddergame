//
//  main.swift
//  LadderGame
//
//  Created by JK on 09/10/2017.
//  Copyright © 2017 Codesquad Inc. All rights reserved.
//

import Foundation

struct LadderGame {
    var numberOfplayers:Int
    var heightOfLadders:Int
    
    var ladders: Array<Array<Bool>> = []
    
    init(players: Int, height: Int) {
        numberOfplayers = players
        heightOfLadders = height
    }
    
    mutating func makeLadders(){
        for _ in 1 ... heightOfLadders {
            var line: Array<Bool> = []
            for _ in 1 ... numberOfplayers {
                let random = Int.random(in: 0...1)
                line.append(random == 1)
            }
            ladders.append(line)
        }
    }
    
    //수정해야할 사항
    //1. 사람 이름 입력
    //2. 사람 이름 출력
    //3. 사람 이름 출력시 공간 확보
    func printLadders(numberOfplayers:Int) {
        for line in ladders {
            repeatPrint(printValue: " ", repeatCount: numberOfplayers)
            print("|",terminator:"")
            for step in line {
                if step {
                    repeatPrint(printValue: "-", repeatCount: numberOfplayers)
                }
                else {
                    repeatPrint(printValue: " ", repeatCount: numberOfplayers)
                }
                print("|",terminator:"")
            }
            print("")
        }
    }
    
    func repeatPrint(printValue:String, repeatCount: Int) {
        for _ in 1pobi,honux,crong,jk...repeatCount {
            print(printValue, terminator:"")
        }
    }
    func printNames(names:Array<String>) {
        for name in names {
            print(name)
        }
    }
}
print("참여할 사람 이름을 입력하세요. (이름은 쉼표(,)로 구분하세요)")
let inputNames = readLine()
let names = inputNames?.split(separator: ",")
let numberOfPlayers = Int(names?.count ?? 0)

print("최대 사다리 높이는 몇 개인가요?")
let height = readLine()
let numberOfHeight = Int(height ?? "0") ?? 0

var game = LadderGame(players: numberOfPlayers, height: numberOfHeight)
game.makeLadders()
game.printLadders(numberOfplayers: numberOfPlayers)
print(names)



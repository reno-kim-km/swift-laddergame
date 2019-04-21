//
//  ladderDraw.swift
//  LadderGame
//
//  Created by 이희찬 on 19/04/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

struct AddLadder {
    
    //임의의 좌표 생성
    func heightCoordinate(_ ladderHeight:Int)->Int{
        return Int(arc4random_uniform(UInt32(ladderHeight)))
    }
    
    func widthCoordinate(_ playerNumber:Int)->Int{
        return (Int(arc4random_uniform(UInt32(playerNumber-1))) * 2) + 1
    }
    
    //세로 사다리 추가
    func addHeight(playerNumber:Int,ladderHeight:Int,ladders:[[Character]])->[[Character]]{
        var ladders = ladders
        for i in 0..<playerNumber{
            for j in 0..<ladderHeight{
                ladders[j][i*2] = "ㅣ"
            }
        }
        return ladders
    }
    
    func Randomcordinates(ladderHeight:Int,playerNumber:Int) -> Array<Int> {
        let height = heightCoordinate(ladderHeight) ,width = widthCoordinate(playerNumber)
        return [height,width]
    }
    
    func isEmpty(ladders:[[Character]],coordinates:Array<Int>,empty:Character,full:Character) -> Character {
        let ladders = ladders
        guard ladders[coordinates[0]][coordinates[1]] == empty else {
            return full
        }
        return empty
    }
    
    func checkRight (ladders:[[Character]],coordinates:Array<Int>,empty:Character,full:Character) -> Character {
        var coordinates = coordinates
        coordinates[1] = coordinates[1] + 2
        return isEmpty(ladders: ladders, coordinates: coordinates, empty: empty, full: full)
    }
    
    func checkLeft (ladders:[[Character]],coordinates:Array<Int>,empty:Character,full:Character) -> Character {
        var coordinates = coordinates
        coordinates[1] = coordinates[1] - 2
        return isEmpty(ladders: ladders, coordinates: coordinates, empty: empty, full: full)
    }
    
    func checkRightLeft(ladders:[[Character]],coordinates:Array<Int>,empty:Character,full:Character) -> Character {
        let right = checkRight(ladders: ladders, coordinates: coordinates, empty: empty, full: full)
        let left = checkLeft(ladders: ladders, coordinates: coordinates, empty: empty, full: full)
        guard right == empty && left == empty else{
            return full
        }
        return empty
    }
    
    
    func isContinue(ladders:[[Character]],coordinates:Array<Int>,ladderWidthLength:Int,empty:Character,full:Character) -> Character {
        switch coordinates[1] {
        case 1:
            return checkRight(ladders: ladders, coordinates: coordinates, empty: empty, full: full)
        case ladderWidthLength - 2 :
            return checkLeft(ladders: ladders, coordinates: coordinates, empty: empty, full: full)
        default:
            return checkRightLeft(ladders: ladders, coordinates: coordinates, empty: empty, full: full)
        }
    }
    
    func shouldreturncoordinate(ladders:[[Character]],empty:Character,full:Character,ladderHeight:Int,playerNumber:Int) -> Array<Int> {
        let coordinates = Randomcordinates(ladderHeight:ladderHeight, playerNumber:playerNumber)
        guard isEmpty(ladders: ladders, coordinates: coordinates, empty: empty, full: full) == empty else {
            return shouldreturncoordinate(ladders:ladders,empty:empty,full:full,ladderHeight:ladderHeight,playerNumber:playerNumber)
        }
        return coordinates
    }
    
    func canMarking(ladders:[[Character]],ladderWidthLength:Int,empty:Character,full:Character,ladderHeight:Int,playerNumber:Int) -> Array<Int> {
        let coordinates = shouldreturncoordinate(ladders: ladders, empty: empty, full: full, ladderHeight: ladderHeight, playerNumber: playerNumber)
        guard isContinue(ladders: ladders, coordinates: coordinates, ladderWidthLength: ladderWidthLength, empty: empty, full: full) == empty else {
            return canMarking(ladders: ladders, ladderWidthLength: ladderWidthLength, empty: empty, full: full, ladderHeight: ladderHeight, playerNumber: playerNumber)
        }
        return coordinates
    }
    
    func marking(ladders:[[Character]],coordinates:Array<Int>) -> [[Character]] {
        var ladders = ladders
        ladders[coordinates[0]][coordinates[1]] = "-"
        return ladders
    }
    
    func addWidth(widthLadderNumber:Int,ladders:[[Character]],ladderHeight:Int,playerNumber:Int,ladderWidthLength:Int) -> [[Character]] {
        let empty:Character = " ", full:Character = "-"
        var ladders = ladders
        var index = 0
        let ladderNum = ladderWidthLength
        while index < ladderNum {
            let coordinates = canMarking(ladders: ladders, ladderWidthLength: ladderWidthLength, empty: empty, full: full, ladderHeight: ladderHeight, playerNumber: playerNumber)
            ladders = marking(ladders: ladders, coordinates: coordinates)
            index += 1
        }
        return ladders
    }
}

struct Function {
    func playDraw(ladder:LadderGameBasicValue) -> [[Character]] {
        let ladderDraw = AddLadder()
        var ladder = ladder
        var ladders = ladder.ladders
        ladders = ladderDraw.addHeight(playerNumber: ladder.playerNumber, ladderHeight: ladder.ladderHeight, ladders: ladders)
        ladders = ladderDraw.addWidth(widthLadderNumber: ladder.widthLadderNumber, ladders: ladders, ladderHeight: ladder.ladderHeight, playerNumber: ladder.playerNumber, ladderWidthLength: ladder.ladderWidthLength)
        return ladders
    }
}

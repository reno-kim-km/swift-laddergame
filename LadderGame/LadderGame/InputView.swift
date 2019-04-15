//
//  InputView.swift
//  LadderGame
//
//  Created by Daheen Lee on 12/04/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

enum InputError: Error {
    case invalidNamesOfPlayers
    case invalidHeightOfLadder
}

struct InputView {
    private let questionForNames = "참여할 사람 이름 (1명 이상, 쉼표,로 구분하세요): "
    private let questionForHeight = "최대 사다리 높이"
    
    func getLadderDataForGame() -> ([String]?, Int?){
        do{
            let namesOfPlayers: [String] = try getNamesOfPlayers()
            let maxHeightOfLadder: Int = try getHeightOfLadder()
            return (namesOfPlayers, maxHeightOfLadder)
        } catch {
            print("Error while processing input: \(error)")
            return (nil, nil)
        }
    }
    
    //get names of player
    private func getNamesOfPlayers() throws -> [String] {
        guard let namesInLine = getAnswerTo(questionForNames) else {
            throw InputError.invalidNamesOfPlayers
        }
        let splitedNames = namesInLine.components(separatedBy: ",")
        if areNamesInvalidForGame(namesOfPlayer: splitedNames) {
            throw InputError.invalidNamesOfPlayers
        }
        return splitedNames
    }
    
    private func areNamesInvalidForGame(namesOfPlayer: [String]) -> Bool {
        return namesOfPlayer.isEmpty || namesOfPlayer.contains("") || namesOfPlayer.count == 1 || namesOfPlayer.contains(" ")
    }
    
    //get height of ladder
    private func getHeightOfLadder() throws -> Int {
        guard let maxHeightOfLadder = getAnswerTo(questionForHeight) else {
            throw InputError.invalidHeightOfLadder
        }
        guard let convertedHeight = Int(maxHeightOfLadder) else {
            throw InputError.invalidHeightOfLadder
        }
        return convertedHeight
    }
    
    private func getAnswerTo(_ question: String) -> String? {
        print(question)
        guard let answer = readLine() else {
            return nil
        }
        return answer
    }
}

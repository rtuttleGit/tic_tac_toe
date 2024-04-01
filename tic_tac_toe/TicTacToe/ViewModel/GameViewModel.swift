//
//  GameViewModel.swift
//  tic_tac_toe
//
//  Created by M29002 on 3/30/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var board: Gameboard
    var currentPlayer: Player
    var gameOver = false
    
    private let dimension: Int
    private let player1 = Player(id: 1)
    private let player2 = Player(id: 2)
    private var winningCombinations: [Set<Int>] = []
    
    init(dimension: Int = 4) {
        self.dimension = dimension
        board = Gameboard(dimension: dimension)
        currentPlayer = player1
        addWinningCombinations()
    }
}

extension GameViewModel {
    
    func clearBoard() {
        board = Gameboard(dimension: dimension)
        currentPlayer = player1
        gameOver = false
    }
    
    private func addWinningCombinations() {
        winningRows()
        winningColumns()
        winningDiagnols()
        fourCorners()
        winningTwoByTwo()
    }
    
    private func isWinner() -> Bool {
        let temp = Set(board.spaces.enumerated().filter { $1.occupiedType == currentPlayer.mark }.map { $0.offset })
        let winningSet = winningCombinations.filter { $0.isSubset(of: temp) }.first
        guard let winningSet = winningSet else { return false }
        winningSet.forEach({ index in
            board.spaces[index].isWinningSpace = true
        })
        gameOver = winningSet.count != 0
        return gameOver
    }
}


// MARK: - Winning Combinations
extension GameViewModel {
    
    private func winningRows() {
        var offSet = dimension
        for i in 0..<board.spaces.count {
            if(i % dimension == 0) {
                let row = Set(i...offSet-1)
                offSet += dimension
                winningCombinations.append(row)
            }
        }
    }
    
    private func winningColumns() {
        for i in 0..<dimension {
            let column = board.spaces.enumerated().filter { index, element in
                return index % dimension == 0 + i
            }.map { index, elemment in
                return index
            }
            winningCombinations.append(Set(column))
        }
    }
    
    private func winningDiagnols() {
        let diagnol1 = board.spaces.enumerated().filter { index, element in
            return index % (dimension+1) == 0
        }.map { index, elemment in
            return index
        }
        
        let diagnol2 = board.spaces.enumerated().filter { index, element in
            return index != 0 && (index % (dimension-1) == 0) && index != board.spaces.count - 1
        }.map { index, elemment in
            
            return index
        }
        winningCombinations.append(Set(diagnol1))
        winningCombinations.append(Set(diagnol2))
    }
    
    private func fourCorners() {
        let fourCorners = [0,dimension-1, board.spaces.count-dimension, board.spaces.count-1]
        winningCombinations.append(Set(fourCorners))
    }
    
    private func winningTwoByTwo() {
        for i in 0..<board.spaces.count {
            guard i % dimension != dimension - 1 else { continue }
            let twoBytwoArray: [Int] = [i, i + 1, i + dimension, i + dimension + 1]
            winningCombinations.append(Set(twoBytwoArray))
        }
    }
}

// MARK: - Tap Gesture
extension GameViewModel {
    
    func tapBox(row: Int, col: Int) {
        var box = board[row, col]
        guard box.occupiedType == nil else { return }
        board[row, col] = box.setType(currentPlayer.mark)
        if !isWinner() { currentPlayer = currentPlayer.id == 1 ? player2 : player1 }
    }
}

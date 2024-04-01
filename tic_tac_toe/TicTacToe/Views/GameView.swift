//
//  GameView.swift
//  tic_tac_toe
//
//  Created by M29002 on 3/30/24.
//

import SwiftUI

struct GameView: View {
    // Change value to test dimension
    @StateObject var vm = GameViewModel(dimension: 4)
    
    var body: some View {
        VStack {
            currentPlayerView
            Spacer()
            boardView
            Spacer()
            newGameBtn
        }
        .padding()
    }
}

extension GameView {
    
    var currentPlayerView: some View {
        HStack {
            Text(vm.gameOver ? "Player \(vm.currentPlayer.id) Wins!" : "Current Player")
            Image(systemName: vm.currentPlayer.id == 1 ? "xmark" : "circle")
                .font(.largeTitle)
        }
    }
    
    var boardView: some View {
        VStack(spacing: 0) {
            ForEach(0..<vm.board.numberOfRows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<vm.board.numberOfColumns, id: \.self) { col in
                        boxView(row: row, col: col)
                    }
                }
            }
        }
    }
    
    var newGameBtn: some View {
        VStack {
            Button {
                vm.clearBoard()
            } label: {
                Text("New Game")
                    .padding()
            }
        }
    }
    
    func boxView(row: Int, col: Int) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 50, height: 50)
                .foregroundColor(vm.board[row, col].isWinningSpace ? Color.green : Color.white)
                .border(.gray, width: 1)
                .onTapGesture {
                    vm.tapBox(row: row, col: col)
                }
            
            if let box = vm.board[row, col], box.occupiedType != nil {
                Image(systemName: box.occupiedType == .xMark ? "xmark" : "circle")
                    .font(.largeTitle)
            }
        }
        .disabled(vm.gameOver)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

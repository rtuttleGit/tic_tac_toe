//
//  Player.swift
//  tic_tac_toe
//
//  Created by M29002 on 3/30/24.
//

import Foundation

struct Player {
    let id: Int
    let mark: PieceType
    
    init(id: Int) {
        self.id = id
        mark = id == 1 ? .xMark : .oMark
    }
}

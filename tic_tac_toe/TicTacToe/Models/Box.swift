//
//  Box.swift
//  tic_tac_toe
//
//  Created by M29002 on 3/30/24.
//

import Foundation

struct Box {
    var isWinningSpace: Bool = false
    private(set) var occupiedType: PieceType?

    mutating func setType(_ type: PieceType) -> Box {
        return Box(occupiedType: type)
    }
}

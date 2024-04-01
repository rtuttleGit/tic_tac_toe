//
//  Gameboard.swift
//  tic_tac_toe
//
//  Created by M29002 on 3/31/24.
//

import Foundation

struct Gameboard {
    var spaces: Array<Box>
    let numberOfRows: Int
    let numberOfColumns: Int

    init(dimension: Int) {
      numberOfRows = dimension
      numberOfColumns = dimension
      spaces = Array<Box>(repeating: Box(), count: numberOfRows * numberOfColumns)
  }

  subscript(row: Int, col: Int) -> Box {
    get {
      return spaces[(row * numberOfColumns) + col]
    }
    set(newValue) {
        spaces[(row * numberOfColumns) + col] = newValue
    }
  }
}

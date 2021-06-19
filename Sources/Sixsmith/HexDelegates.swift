//
//  HexDelegates.swift
//  Sixsmith
//
//  Created by Edward Toy on 01/01/2021.
//

public protocol HexDrawDelegate: AnyObject {
    func dataForHex(_ hex: Hex, drawData: DrawData)
    func drawDidFinish()
}

public protocol HexTouchDelegate: AnyObject {
    func touchAtHex(_ hex: Hex)
}

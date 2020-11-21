//
//  NameDescribable.swift
//  UICollectionViewWithinUITableViewCell
//
//  Created by Maysam Shahsavari on 2020-11-21.
//
// Credit: https://stackoverflow.com/questions/24494784/get-class-name-of-object-as-string-in-swift

import Foundation
/**
 To return the type name as `String`.
 */
protocol NameDescribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    var typeName: String {
        return String(describing: type(of: self))
    }

    static var typeName: String {
        return String(describing: self)
    }
}

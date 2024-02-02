//
//  ReusableViewProtocol.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//


import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UITableViewCell : ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

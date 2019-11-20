//
//  UIViewController_adds.swift
//  CombineApp1
//
//  Created by Mac on 02.11.2019.
//  Copyright © 2019 Lammax. All rights reserved.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}

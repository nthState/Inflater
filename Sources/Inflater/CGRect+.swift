//
//  CGRect+.swift
//  InflateApp
//
//  Created by Chris Davis on 25/03/2022.
//

import Foundation
import CoreGraphics

internal extension CGRect {

  /// Creates a unit CGRect of size: 1x1
  static var unit: CGRect {
    CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
  }

}

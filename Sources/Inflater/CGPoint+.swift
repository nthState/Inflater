//
//  CGPoint+.swift
//  InflateApp
//
//  Created by Chris Davis on 25/03/2022.
//

import Foundation
import CoreGraphics

internal extension CGPoint {

  init(_ animatablePoint: CGPoint.AnimatableData) {
    self = CGPoint(x:animatablePoint.first, y: animatablePoint.second)
  }

}

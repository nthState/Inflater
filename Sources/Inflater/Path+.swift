//
//  Path+.swift
//  InflateApp
//
//  Created by Chris Davis on 25/03/2022.
//

import CoreGraphics
import SwiftUI

internal extension Path {

  func totalPoints() -> Int {
    var counter = 0
    self.forEach { element in
      switch element {
      case .move(to: let to):
        counter += 1
      case .line(to: let to):
        counter += 1
      case .quadCurve(to: let to, control: let control):
        counter += 2
      case .curve(to: let to, control1: let control1, control2: let control2):
        counter += 3
      case .closeSubpath:
        counter += 1
      }
    }

    return counter
  }

  func allElements() -> [Path.Element] {
      var elements: [Path.Element] = []
      self.forEach { element in
        elements.append(element)
      }
      return elements
    }

}

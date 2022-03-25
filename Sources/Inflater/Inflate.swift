//
//  Inflate.swift
//  InflateApp
//
//  Created by Chris Davis on 25/03/2022.
//

import Foundation
import SwiftUI

extension Shape {

  func inflate(scale: CGFloat, amount: CGFloat) -> some Shape {
    return Inflate(shape: self, scale: scale, amount: amount)
      .newShape()
  }

}

struct Inflate<S>: Animatable where S: Shape {

  let path: Path
  let scaledPath: Path

  let scale: CGFloat
  var amount: CGFloat

  public init(shape: S, scale: CGFloat, amount: CGFloat) {

    self.scale = scale
    self.amount = amount

    self.path = shape.path(in: CGRect(x: 0, y: 0, width: 50, height: 50))

    self.scaledPath = self.path.applying(CGAffineTransform.init(scaleX: scale, y: scale))
  }

  private func getCombinedPath() -> [Path.Element] {
    let count = self.path.totalPoints()
    let percentageToInt = Int(CGFloat(count) * amount)

    let first = self.path.allElements()
    let second = self.scaledPath.allElements()

    var elements = [Path.Element]()
    for i in 0..<count {
      if i < percentageToInt {
        elements.append(second[i])
      } else {
        elements.append(first[i])
      }
    }

    return elements
  }

  private func getElements() -> [AnimatableElement] {

    let elements = getCombinedPath()

    let animatableElements: [AnimatableElement] = elements.compactMap ({ element in
      switch element {
      case .move(to: let to):
        return AnimatableElement(type: .move(to: to), to: to.animatableData, control1: .zero, control2: .zero)
      case .line(to: let to):
        return AnimatableElement(type: .line(to: to), to: to.animatableData, control1: .zero, control2: .zero)
      case .quadCurve(to: let to, control: let control):
        return AnimatableElement(type: .quadCurve(to: to, control: control), to: to.animatableData, control1: control.animatableData, control2: control.animatableData)
      case .curve(to: let to, control1: let control1, control2: let control2):
        return AnimatableElement(type: .curve(to: to, control1: control1, control2: control2), to: to.animatableData, control1: control1.animatableData, control2: control2.animatableData)
      case .closeSubpath:
        return AnimatableElement(type: .closeSubpath, to:.zero, control1: .zero, control2: .zero)
      }
    })

    return animatableElements
  }

  public func newShape() -> some Shape {
    SubdividedShape(elements: getElements())
  }

}

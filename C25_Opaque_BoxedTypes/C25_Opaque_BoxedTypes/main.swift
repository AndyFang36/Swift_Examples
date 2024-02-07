//
//  main.swift
//  C25_Opaque_BoxedTypes
//  Hide implementation details about a value’s type.
//  Created by Andy Fang on 07/02/2024.
//

import Foundation

protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int

    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

struct FlippedShape<T: Shape>: Shape {
    var shape: T

    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U

    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

// eg.1
let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())
// eg.2
let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())
// eg.3
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangles.draw())


/* Returning an Opaque Type */
struct Square: Shape {
    var size: Int

    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}

let trapezoid = makeTrapezoid()
print(trapezoid.draw())


func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}

func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}

let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
print(opaqueJoinedTriangles.draw())

//! func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
//!     if shape is Square {
//!         return shape // Error: return types don't match
//!     }
//!     return FlippedShape(shape: shape) // Error: return types don't match
//! }


/** Boxed Protocol Types */
struct VerticalShapes: Shape {
    var shapes: [any Shape]

    func draw() -> String {
        return shapes.map { $0.draw() }.joined(separator: "\n\n")
    }
}

let largeTriangle = Triangle(size: 5)
let largeSquare = Square(size: 5)
let vertical = VerticalShapes(shapes: [largeTriangle, largeSquare])
print(vertical.draw())

if let downcastTriangle = vertical.shapes[0] as? Triangle {
    print(downcastTriangle.size)
}


/* Differences Between Opaque Types and Boxed Protocol Types */
func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }
    
    return FlippedShape(shape: shape)
}

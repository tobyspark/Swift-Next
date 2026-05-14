// SYNTAX TEST "Swift.sublime-syntax"

// SE-0377 borrowing / consuming parameter modifiers (Swift 5.9)
// SE-0366 consume operator
// SE-0390 discard / ~Copyable

func take(_ x: borrowing String) {}
//             ^^^^^^^^^ storage.modifier.ownership.borrowing.swift

func eat(_ x: consuming String) {}
//            ^^^^^^^^^ storage.modifier.ownership.consuming.swift

func move() {
    let y = consume x
//          ^^^^^^^ keyword.operator.word.consume.swift
}

struct File: ~Copyable {
//           ^ keyword.operator.suppressed-conformance.swift
//            ^^^^^^^^ support.class.swift
    consuming func close() {
//  ^^^^^^^^^ storage.modifier.ownership.consuming.swift
        discard self
//      ^^^^^^^ keyword.control.flow.discard.swift
    }
}

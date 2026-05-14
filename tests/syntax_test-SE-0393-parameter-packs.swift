// SYNTAX TEST "Swift.sublime-syntax"

// SE-0393 Value and Type Parameter Packs (Swift 5.9)
// SE-0398 Allow Generic Types to Abstract Over Packs

func zip<each S: Sequence>(_ sequences: repeat each S) {}
//       ^^^^ keyword.operator.expansion.each.swift
//                                       ^^^^^^ keyword.operator.expansion.repeat.swift
//                                              ^^^^ keyword.operator.expansion.each.swift

struct Tuple<each T> {
//           ^^^^ keyword.operator.expansion.each.swift
    let values: (repeat each T)
//               ^^^^^^ keyword.operator.expansion.repeat.swift
//                      ^^^^ keyword.operator.expansion.each.swift
}

repeat {
// <- keyword.control.loop.repeat.swift
    doThing()
} while condition

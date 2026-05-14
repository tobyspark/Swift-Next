// SYNTAX TEST "Swift.sublime-syntax"

// SE-0412 nonisolated(unsafe) (Swift 6.0)

nonisolated(unsafe) var shared: Int = 0
// <- storage.modifier.actor-isolation.nonisolated.swift
//^^^^^^^^^^ storage.modifier.actor-isolation.nonisolated.swift
//          ^ punctuation.section.parens.begin.swift
//           ^^^^^^ constant.language.attribute-option.swift
//                 ^ punctuation.section.parens.end.swift

nonisolated var plain = 1
// <- storage.modifier.actor-isolation.nonisolated.swift

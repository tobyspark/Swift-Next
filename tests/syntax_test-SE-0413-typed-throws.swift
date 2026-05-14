// SYNTAX TEST "Swift.sublime-syntax"

// SE-0413 Typed throws (Swift 6.0)

func parse() throws(ParseError) -> Int {
//           ^^^^^^ keyword.declaration.throws.swift
//                 ^ punctuation.section.parens.begin.swift
//                  ^^^^^^^^^^ support.class.swift
//                            ^ punctuation.section.parens.end.swift
    throw .invalid
}

func plain() throws -> Int { throw .err }
//           ^^^^^^ keyword.declaration.throws.swift

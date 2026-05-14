// SYNTAX TEST "Swift.sublime-syntax"

// SE-0354 Regex Literals / SE-0355 Regex Syntax (Swift 5.7)
//
// Only the extended-delimiter form (#/.../#) is implemented. The bare /.../
// form is deferred — see UPDATE_PLAN.md "Risk / hard cases" #1.

let digits = #/\d+/#
//           ^ punctuation.definition.annotation.begin.swift
//            ^ punctuation.definition.string.begin.swift
//             ^^^ string.regexp.swift
//                ^ punctuation.definition.string.end.swift
//                 ^ punctuation.definition.annotation.end.swift

let withSlash = #/a\/b/#
//              ^ punctuation.definition.annotation.begin.swift
//               ^ punctuation.definition.string.begin.swift
//                ^^^^ string.regexp.swift

let hashed = ##/contains/#inside/##
//           ^^ punctuation.definition.annotation.begin.swift
//             ^ punctuation.definition.string.begin.swift
//              ^^^^^^^^^^^^^^^ string.regexp.swift
//                             ^ punctuation.definition.string.end.swift
//                              ^^ punctuation.definition.annotation.end.swift

let multiline = #/
//              ^ punctuation.definition.annotation.begin.swift
//               ^ punctuation.definition.string.begin.swift
    \d+
//  ^^^ string.regexp.swift
    [a-z]+
//  ^^^^^^ string.regexp.swift
    /#
//  ^ punctuation.definition.string.end.swift
//   ^ punctuation.definition.annotation.end.swift

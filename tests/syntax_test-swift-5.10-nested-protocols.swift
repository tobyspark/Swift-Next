// SYNTAX TEST "Swift.sublime-syntax"

// Swift 5.10 — nested protocols (no SE proposal number; TSPL 2024-03-05).
// No new tokens; pin existing scopes inside nested-protocol contexts.

struct Outer {
    protocol Inner {
//  ^^^^^^^^ keyword.declaration.protocol.swift
        @MainActor func run() async
//      ^^^^^^^^^^ support.function.annotation.swift
//                 ^^^^ keyword.declaration.function.swift
//                              ^^^^^ keyword.declaration.async.swift
    }
}

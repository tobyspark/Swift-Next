// SYNTAX TEST "Swift.sublime-syntax"

// SE-0386 New access modifier: package (Swift 6.0)

package func sharedAcrossModules() {}
// <- storage.modifier.access-level.package.swift
//^^^^^^^ storage.modifier.access-level.package.swift
//        ^^^^ keyword.declaration.function.swift

package class Box {
// <- storage.modifier.access-level.package.swift
    package var contents: String = ""
//  ^^^^^^^ storage.modifier.access-level.package.swift
    package(set) var counter = 0
//  ^^^^^^^ storage.modifier.access-level.package.swift
//         ^ punctuation.section.parens.begin.swift
//          ^^^ variable.parameter.setter-access-level.swift
//             ^ punctuation.section.parens.end.swift
}

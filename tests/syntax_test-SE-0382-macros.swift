// SYNTAX TEST "Swift.sublime-syntax"

// SE-0382 Expression Macros / SE-0389 Attached Macros (Swift 5.9)

@freestanding(expression)
// <- meta.annotation.swift punctuation.definition.annotation.swift
//^^^^^^^^^^^^ support.function.annotation.swift
//             ^^^^^^^^^^ constant.language.attribute-option.swift
public macro stringify<T>(_ value: T) -> (T, String)
//     ^^^^^ keyword.declaration.macro.swift

@attached(member, names: named(init))
// <- meta.annotation.swift punctuation.definition.annotation.swift
//^^^^^^^^ support.function.annotation.swift
//         ^^^^^^ constant.language.attribute-option.swift
public macro AddInit() = #externalMacro(module: "MyMacros", type: "AddInit")
//     ^^^^^ keyword.declaration.macro.swift

let n = #stringify(1 + 2)
//      ^ punctuation.definition.preprocessor.swift
//       ^^^^^^^^^ variable.function.macro.swift

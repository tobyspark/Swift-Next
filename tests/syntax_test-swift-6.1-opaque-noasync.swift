// SYNTAX TEST "Swift.sublime-syntax"

// Swift 6.1 — opaque parameter types restated (SE-0341 echo);
// @available(*, noasync) refresh.

func render(_ x: some Equatable) {}
//               ^^^^ storage.modifier.opaque.swift
//                    ^^^^^^^^^ support.class.swift

@available(*, noasync, message: "use async variant")
// <- meta.annotation.swift punctuation.definition.annotation.swift
//^^^^^^^^^ support.function.annotation.swift
//          ^ constant.language.preprocessor.wildcard.swift
//             ^^^^^^^ constant.language.preprocessor.platform-name.swift
func legacyBlocking() {}

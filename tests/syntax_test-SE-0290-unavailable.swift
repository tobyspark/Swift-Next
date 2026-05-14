// SYNTAX TEST "Swift.sublime-syntax"

// SE-0290 #unavailable condition (Swift 5.6 / refined 5.7)

if #unavailable(iOS 14, *) {
// ^ punctuation.definition.preprocessor.swift
//  ^^^^^^^^^^^ keyword.other.preprocessor.swift
//             ^ punctuation.section.parens.begin.swift
//              ^^^ constant.language.preprocessor.platform-name.swift
//                  ^^ constant.numeric.value.swift
//                       ^ constant.language.preprocessor.wildcard.swift
//                        ^ punctuation.section.parens.end.swift
    loadLegacyPath()
}

if #available(iOS 15, *), #unavailable(macOS 12, *) {
//                        ^ punctuation.definition.preprocessor.swift
//                         ^^^^^^^^^^^ keyword.other.preprocessor.swift
}

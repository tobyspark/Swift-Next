// SYNTAX TEST "Swift.sublime-syntax"

// Swift 6.2: #isolation (SE-0420), sending (SE-0430),
// ~Sendable (SE-0470), nonisolated(nonsending) (SE-0461)

func current() -> (any Actor)? { #isolation }
//                               ^ punctuation.definition.preprocessor.swift
//                                ^^^^^^^^^ keyword.other.preprocessor.swift

func transfer(_ value: sending Payload) {}
//                     ^^^^^^^ storage.modifier.sending.swift

struct Plain: ~Sendable {}
//            ^ keyword.operator.suppressed-conformance.swift
//             ^^^^^^^^ support.class.swift

@MainActor nonisolated(nonsending) func leak() async {}
//         ^^^^^^^^^^^ storage.modifier.actor-isolation.nonisolated.swift
//                    ^ punctuation.section.parens.begin.swift
//                     ^^^^^^^^^^ constant.language.attribute-option.swift
//                               ^ punctuation.section.parens.end.swift

func describe(value: Status) -> String {
    if case .ready = value {
//     ^^^^ keyword.control.conditional.case.swift
        return "ready"
    }
    return "other"
}

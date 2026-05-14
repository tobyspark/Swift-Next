// SYNTAX TEST "Swift.sublime-syntax"

// SE-0346 Lightweight same-type requirements for primary associated types (Swift 5.7)

protocol Container<Element> {
//       ^^^^^^^^^ entity.name.protocol.swift
//                ^ punctuation.definition.generic.begin.swift
//                 ^^^^^^^ support.other.swift
//                        ^ punctuation.definition.generic.end.swift
    associatedtype Element
//  ^^^^^^^^^^^^^^ keyword.declaration.associatedtype.swift
}

func takeStringContainer(_ c: some Container<String>) {}
//                            ^^^^ storage.modifier.opaque.swift
//                                 ^^^^^^^^^ support.class.swift

func takeAnyContainer(_ c: any Container<Element == Int>) {}
//                         ^^^ storage.modifier.existential.swift

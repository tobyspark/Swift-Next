// SYNTAX TEST "Swift.sublime-syntax"

// SE-0335 Introduce existential `any` (Swift 5.7)

func eat(_ animal: any Animal) {}
//                 ^^^ storage.modifier.existential.swift
//                     ^^^^^^ support.class.swift

func feed() -> any Animal { fatalError() }
//             ^^^ storage.modifier.existential.swift

let zoo: [any Animal] = []
//        ^^^ storage.modifier.existential.swift

let pet: any Animal & Trainable = dog
//       ^^^ storage.modifier.existential.swift

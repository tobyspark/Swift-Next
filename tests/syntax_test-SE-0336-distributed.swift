// SYNTAX TEST "Swift.sublime-syntax"

// SE-0336 Distributed Actor Isolation (Swift 5.7)

distributed actor Greeter {
// <- storage.modifier.distributed.swift
//^^^^^^^^^^ storage.modifier.distributed.swift
//          ^^^^^ keyword.declaration.actor.swift
//                ^^^^^^^ entity.name.actor.swift

    distributed func hello() -> String { "hi" }
//  ^^^^^^^^^^^ storage.modifier.distributed.swift
//              ^^^^ keyword.declaration.function.swift
}

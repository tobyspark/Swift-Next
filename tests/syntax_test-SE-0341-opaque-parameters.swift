// SYNTAX TEST "Swift.sublime-syntax"

// SE-0341 Opaque Parameter Declarations (Swift 5.7)

func describe(_ value: some CustomStringConvertible) {}
//                     ^^^^ storage.modifier.opaque.swift
//                          ^^^^^^^^^^^^^^^^^^^^^^^^ support.class.swift

func feed(_ animals: [some Animal]) {}
//                    ^^^^ storage.modifier.opaque.swift

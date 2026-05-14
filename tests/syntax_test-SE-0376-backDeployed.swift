// SYNTAX TEST "Swift.sublime-syntax"

// SE-0376 Function Back Deployment (Swift 5.8)

@backDeployed(before: iOS 17, macOS 14)
// <- meta.annotation.swift punctuation.definition.annotation.swift
//^^^^^^^^^^^^ support.function.annotation.swift
public func niceThing() {}

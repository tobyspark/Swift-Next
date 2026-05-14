// SYNTAX TEST "Swift.sublime-syntax"

// SE-0367 Conditional compilation for attributes (Swift 5.8)
// SE-0212 Compiler version directive (hasFeature)

#if hasAttribute(preconcurrency)
//  ^^^^^^^^^^^^ support.function.preprocessor.platform-condition.swift
@preconcurrency protocol P {}
#endif

#if hasFeature(StrictConcurrency)
//  ^^^^^^^^^^ support.function.preprocessor.platform-condition.swift
import Concurrency
#endif

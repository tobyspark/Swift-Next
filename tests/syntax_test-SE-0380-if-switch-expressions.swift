// SYNTAX TEST "Swift.sublime-syntax"

// SE-0380 if and switch expressions (Swift 5.9)

let value = if condition { 1 } else { 2 }
//          ^^ keyword.control.conditional.if.swift
//                         ^ constant.numeric.value.swift
//                             ^^^^ keyword.control.conditional.else.swift

let label = switch score {
//          ^^^^^^ keyword.control.conditional.switch.swift
    case 0..<50: "fail"
//  ^^^^ keyword.control.conditional.case.swift
    default: "pass"
//  ^^^^^^^ keyword.control.conditional.default.swift
}

func decide() -> Int {
    return if flag { 1 } else { 0 }
//         ^^ keyword.control.conditional.if.swift
}

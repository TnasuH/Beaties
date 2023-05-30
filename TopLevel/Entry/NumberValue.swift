enum NumberValue: ExpressibleByStringLiteral {
    case number(String)
    case delete
    case done

    init(stringLiteral: String) {
        self = .number(stringLiteral)
    }
}

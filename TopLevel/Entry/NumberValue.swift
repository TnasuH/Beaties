enum NumberValue: ExpressibleByStringLiteral, Identifiable {
    var id: String {
        switch self {
        case .number(let numberString): numberString
        case .delete: "􁂈"
        case .done: "􀅇"
        }
    }

    case number(String)
    case delete
    case done

    init(stringLiteral: String) {
        self = .number(stringLiteral)
    }
}

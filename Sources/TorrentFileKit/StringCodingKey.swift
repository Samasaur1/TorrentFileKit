struct StringCodingKey: CodingKey {
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    init?(intValue: Int) {
        return nil
    }

    var intValue: Int? {
        return nil
    }
}

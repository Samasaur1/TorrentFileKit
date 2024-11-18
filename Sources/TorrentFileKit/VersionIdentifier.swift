struct VersionIdentifier: Decodable {
    let version: Int

    init(from decoder: any Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: StringCodingKey.self)
        let infoContainer = try rootContainer.nestedContainer(keyedBy: StringCodingKey.self, forKey: StringCodingKey(stringValue: "info")!)
        self.version = try infoContainer.decode(Int.self, forKey: StringCodingKey(stringValue: "meta version")!)
    }
}

import BencodeKit
import Foundation

struct TorrentFileV2: Codable {
    struct InfoDictionary: Codable {
        struct MultipleFileInfo {
            let length: Int
            let path: [String]
            let piecesRoot: Data?
        }
        struct RawMultipleFileInfo: Codable {
            let length: Int
            let piecesRoot: Data?

            enum CodingKeys: String, CodingKey {
                case length
                case piecesRoot = "pieces root"
            }
        }
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


        let name: String
        let pieceLength: Int
        let metaVersion: Int
        let fileTree: [MultipleFileInfo]

        init(from decoder: any Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try rootContainer.decode(String.self, forKey: .name)
            self.pieceLength = try rootContainer.decode(Int.self, forKey: .pieceLength)
            self.metaVersion = try rootContainer.decode(Int.self, forKey: .metaVersion)

            let fileTreeContainer = try rootContainer.nestedContainer(keyedBy: StringCodingKey.self, forKey: .fileTree)

            func recurse(into container: KeyedDecodingContainer<StringCodingKey>, at basePath: [String]) throws -> [MultipleFileInfo] {
                var results: [MultipleFileInfo] = []
                for key in container.allKeys {
                    if key.stringValue == "" {
                        let file = try container.decode(RawMultipleFileInfo.self, forKey: key)
                        if container.allKeys.count != 1 {
                            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Multiple files at the same path!")
                            throw DecodingError.dataCorrupted(context)
                        } else {
                            return [MultipleFileInfo(length: file.length, path: basePath, piecesRoot: file.piecesRoot)]
                        }
                    } else {
                        let nextLevelContainer = try container.nestedContainer(keyedBy: StringCodingKey.self, forKey: key)
                        let files = try recurse(into: nextLevelContainer, at: basePath + [key.stringValue])
                        results.append(contentsOf: files)
                    }
                }
                return results
            }

            self.fileTree = try recurse(into: fileTreeContainer, at: [])
        }
        func encode(to encoder: any Encoder) throws {
            var rootContainer = encoder.container(keyedBy: CodingKeys.self)
            try rootContainer.encode(self.name, forKey: .name)
            try rootContainer.encode(self.pieceLength, forKey: .pieceLength)
            try rootContainer.encode(self.metaVersion, forKey: .metaVersion)

            let fileTreeContainer = rootContainer.nestedContainer(keyedBy: StringCodingKey.self, forKey: .fileTree)

            for file in self.fileTree {
                var container = fileTreeContainer
                for segment in file.path {
                    container = container.nestedContainer(keyedBy: StringCodingKey.self, forKey: StringCodingKey(stringValue: segment)!)
                }
                try container.encode(RawMultipleFileInfo(length: file.length, piecesRoot: file.piecesRoot), forKey: StringCodingKey(stringValue: "")!)
            }
        }

        enum CodingKeys: String, CodingKey {
            case name
            case pieceLength = "piece length"
            case metaVersion = "meta version"
            case fileTree = "file tree"
        }
    }

    let announce: String
    let info: InfoDictionary
    let pieceLayers: [String: String]
}

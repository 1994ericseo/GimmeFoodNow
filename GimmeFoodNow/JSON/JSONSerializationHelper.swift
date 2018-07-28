import Foundation

class JSONSerializationHelper {
    func getJSON(fileName: String) -> Any? {
        do {
            if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: [])
                return jsonResult
            }
        } catch {
            return nil
        }
        return nil
    }
}


import Foundation

class Main {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func startProgramm() {
        self.getRepo()
        let runLoop = RunLoop.current
        while runLoop.run(mode: .default, before: .distantFuture) { }
    }
    
    private func getRepo() {
        print("Введите имя репозитория")
        apiService.getRepo(nickName: consoleInput()) { arr in
            print("Список репозиториев")
            print(arr)
            self.getRepo()
        }
    }
    
    private func consoleInput() -> String {
        let availableData = FileHandle.standardInput.availableData
        let strData = String(data: availableData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
}

let main = Main(apiService: APIServiceImp())
main.startProgramm()

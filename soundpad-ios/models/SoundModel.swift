import CoreData

class SoundModel: BaseModel<Sound> {
    
    func url() -> URL {
        return URL(string: self.object.url!)!
    }
}

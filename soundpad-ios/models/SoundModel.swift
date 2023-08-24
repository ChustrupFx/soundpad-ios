import CoreData

class SoundModel: BaseModel<Sound> {
    
    override func delete() {
        super.delete()
        
        let file = url()
        
        
        try? FileManager.default.removeItem(at: file)
        
        
    }
    
    func url() -> URL {
        return URL(string: self.object.url!)!
    }
}

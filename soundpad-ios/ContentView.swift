//
//  ContentView.swift
//  soundpad-ios
//
//  Created by Victor Soares on 17/08/23.
//

import SwiftUI
import CoreData
import AVFoundation
import AVFAudio


struct Audio: Identifiable {
    var id = UUID()
    var url: URL
}

var player: AVAudioPlayer?

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State var fileImporterActive = false
    
    @State var audios: [Audio] = [
    
    ]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)])
    var sounds: FetchedResults<Sound>
    
    var body: some View {
        ScrollView {
            
            Spacer()
            
            ForEach(sounds) { audio in
                var soundModel = SoundModel(object: audio, viewContext: viewContext)
                Button {
                    print("Touched")
                    do {
                        
                        print(URL(string: audio.url!)!.startAccessingSecurityScopedResource())
                        
                        player = try AVAudioPlayer(contentsOf: soundModel.url())
                        
                        
                        if let player = player {
                            print("Playing")
                            player.prepareToPlay()
                            player.play()
                        }
                        
                        soundModel.url().stopAccessingSecurityScopedResource()
                    } catch {
                        print(error)
                    }
                } label: {
                    MusicButtonComponent(name: soundModel.object.name!)
                }
            }
        }
        .toolbar {
            Button {
                fileImporterActive = true
            } label: {
                Image(systemName: "plus.app.fill")
            }
        }
        .fileImporter(isPresented: $fileImporterActive, allowedContentTypes: [.mp3]) { result in
            do {
                
                let url = try result.get()
                
                
                print(url.startAccessingSecurityScopedResource())
                if (url.startAccessingSecurityScopedResource()) {
                    
                    let documentDirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                    let dir = documentDirs[0]
                    let fileDir = dir.appendingPathComponent(url.lastPathComponent)
                    
                    try FileManager.default.copyItem(at: url, to: fileDir)
                    
                    let sound = SoundModel(viewContext: viewContext)
                    
                    sound.object.name = url.absoluteString
                    
                    sound.object.url = fileDir.absoluteString
                    
                    do {
                        try sound.save()
                    } catch {
                        print("asd")
                    }
                }
                
                url.stopAccessingSecurityScopedResource()
                
               
                
            } catch {
                print(error)
                print(error.localizedDescription)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

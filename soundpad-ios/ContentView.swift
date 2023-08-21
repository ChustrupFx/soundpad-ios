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
    
    @State var fileImporterActive = false
    
    @State var audios: [Audio] = [
    
    ]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)])
    var sounds: FetchedResults<Sound>
    
    var body: some View {
        ScrollView {
            
            Spacer()
            
            ForEach(sounds) { audio in
                Button {
                    do {
                        let url = URL(string: audio.url!)!
                        if (url.startAccessingSecurityScopedResource()) {
                            
                            
                            player = try AVAudioPlayer(contentsOf: url)
                            
                            
                            if let player = player {
                                player.prepareToPlay()
                                player.play()
                            }
                            
                            URL(string: audio.url!)!.stopAccessingSecurityScopedResource()
                        }
                        
                    } catch {
                        print(error)
                    }
                } label: {
                    MusicButtonComponent(name: audio.name!)
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
                
                let audio = Audio(url: url)
                
                audios.append(audio)
                
            } catch {
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

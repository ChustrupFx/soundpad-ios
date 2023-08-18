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
    
    var body: some View {
        ScrollView {
            
            Spacer()
            
            ForEach(audios) { audio in
                Button {
                    do {
                        
                        if (audio.url.startAccessingSecurityScopedResource()) {
                            
                            
                            player = try AVAudioPlayer(contentsOf: audio.url)
                            
                            
                            if let player = player {
                                player.prepareToPlay()
                                player.play()
                            }
                            
                            audio.url.stopAccessingSecurityScopedResource()
                        }
                        
                    } catch {
                        print(error)
                    }
                } label: {
                    MusicButtonComponent(name: audio.url.absoluteString)
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

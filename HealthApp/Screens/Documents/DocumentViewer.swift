//
//  Document Viewer.swift
//  HealthApp
//
//  Created by Fernando Archila on 31.03.25.
//

import SwiftUI
import PDFKit
import QuickLook

struct DocumentViewer: View {
    @State  var documents: [FileModel] = []
    @State  var isPickerPresented = false
    @State  var hasConsent = false
    @StateObject private var uploader = FileUploaderService()
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            if (hasConsent){
                VStack{
                    
                    List {
                        ForEach(documents) { document in
                            NavigationLink(destination: DocumentView(documentURL: document.url)) {
                                DocumentListItem(document: document.url)
                                    .accessibilityIdentifier("documentRow_\(document.name)")
                            }
                        }
                        .onDelete(perform: deleteDocument)
                    }
                    .overlay{if documents.isEmpty {
                        EmptyState()
                            .accessibilityLabel("emptyState")
                            .accessibilityIdentifier("emptyState")
                    }
                    }
                    
                }
                
                ZStack{
                    VStack{
                        
                        
                        
                        Spacer()
                        UploadStatusView(isUploading: uploader.isUploading, uploadSuccess: uploader.uploadSuccess, errorMessage: uploader.errorMessage)
                        Button(action: {
                            isPickerPresented.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    Circle()
                                        .fill(Color.blue)
                                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                                )
                        }
                        .padding(.bottom, 20)
                        .accessibilityLabel("addDocumentButton")
                    }}
                
                
            }else {
                VStack{
                    Text("Your Documents will be visible here once the consent is provided")
                    
                        .padding(10)
                        .multilineTextAlignment(.center)
                        .frame(width: 300,alignment: .center)
                    Button(action: {
                        hasConsent = true
                    }) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Provide Consent")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        

                    }
                    .accessibilityLabel("consentButton")
                }
            }
            
        }
        .toolbar {
            if (hasConsent){
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink( destination: SettingsView()){
                        
                        Button(action: { isPickerPresented.toggle() }) {
                            Label("Add", systemImage: "gearshape")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isPickerPresented) {
            DocumentPicker { pickedURL in
                if let pickedURL = pickedURL {
                    Task {
                        let success = await uploader.upload(fileURL: pickedURL)
                        if success {
                            documents.append(FileModel(url: pickedURL))
                            print("📄 Document appended using async/await!")
                        }
                    }
                }
            }
        }
        .navigationTitle("Documents")
        .accessibilityIdentifier("documentListScreen")
        .navigationBarBackButtonHidden(true)
    }
    
    
    func deleteDocument(at offsets: IndexSet) {
        documents.remove(atOffsets: offsets)
    }
}








struct QuickLookPreview: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let items: [URL]
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
        if isPresented {
            //            uiViewController.present(UIViewController, animated: true)
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(items: items)
    }
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let items: [URL]
        
        init(items: [URL]) {
            self.items = items
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            items.count
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return items[index] as QLPreviewItem
        }
    }
}



#Preview {
    DocumentViewer()
}

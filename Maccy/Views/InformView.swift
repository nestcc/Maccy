import Cocoa

class InformView: NSWindow {
    init(text: String) {
        let frame = NSRect(x: 0, y: 0, width: 180, height: 40)
        super.init(contentRect: frame, styleMask: [.borderless], backing: .buffered, defer: false)
        
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .floating
        self.ignoresMouseEvents = true
        
        let visualEffect = NSVisualEffectView(frame: frame)
        visualEffect.blendingMode = .behindWindow
        visualEffect.state = .active
        visualEffect.material = .hudWindow
        visualEffect.wantsLayer = true
        visualEffect.layer?.cornerRadius = 12
        
        let textField = NSTextField(labelWithString: text)
        textField.textColor = .white
        textField.font = NSFont.systemFont(ofSize: 13, weight: .semibold)
        textField.alignment = .center
        textField.frame = frame.offsetBy(dx: 0, dy: -10)
        
        visualEffect.addSubview(textField)
        self.contentView = visualEffect
        self.center()
    }

    func showAndDismiss() {
        self.makeKeyAndOrderFront(nil)
        self.alphaValue = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            NSAnimationContext.runAnimationGroup({ context in
                context.duration = 0.2
                self.animator().alphaValue = 0
            }, completionHandler: {
                self.close()
            })
        }
    }
}

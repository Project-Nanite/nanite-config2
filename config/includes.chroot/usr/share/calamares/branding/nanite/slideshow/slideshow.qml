import QtQuick 2.5

Rectangle {
    id: slideshow
    width: parent.width
    height: parent.height
    color: "#1a1a1a"
    
    property int currentSlide: 0
    property var slides: [
        {
            title: "Welcome to Nanite Linux",
            text: "A Beautiful AI/ML Distribution with stunning design and powerful features.",
            image: "/usr/share/backgrounds/wallpaper.png"
        },
        {
            title: "Modern XFCE Desktop",
            text: "Experience a fast, lightweight, and beautiful desktop environment optimized for productivity.",
            image: "/usr/share/backgrounds/wallpaper.png"
        },
        {
            title: "AI/ML Ready",
            text: "Pre-configured with essential tools and libraries for artificial intelligence and machine learning development.",
            image: "/usr/share/backgrounds/wallpaper.png"
        },
        {
            title: "Beautiful Design",
            text: "Enjoy the modern claymorphism design with the iconic geometric bee logo throughout the system.",
            image: "/usr/share/backgrounds/wallpaper.png"
        }
    ]
    
    Timer {
        id: slideTimer
        interval: 5000
        repeat: true
        running: true
        onTriggered: {
            currentSlide = (currentSlide + 1) % slides.length
        }
    }
    
    // Background image
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: slides[currentSlide].image
        fillMode: Image.PreserveAspectCrop
        opacity: 0.3
    }
    
    // Dark overlay
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.6
    }
    
    // Content
    Column {
        anchors.centerIn: parent
        anchors.margins: 50
        spacing: 30
        width: parent.width - 100
        
        // Logo
        Image {
            id: logo
            source: "/usr/share/pixmaps/nanite-logo.png"
            width: 120
            height: 120
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }
        
        // Title
        Text {
            id: slideTitle
            text: slides[currentSlide].title
            font.pixelSize: 42
            font.bold: true
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }
        
        // Description
        Text {
            id: slideText
            text: slides[currentSlide].text
            font.pixelSize: 18
            color: "#e0e0e0"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            width: parent.width * 0.8
        }
        
        // Website
        Text {
            text: "Visit us at https://nanite.software"
            font.pixelSize: 14
            color: "#888888"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
    
    // Slide indicators
    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30
        spacing: 10
        
        Repeater {
            model: slides.length
            Rectangle {
                width: 12
                height: 12
                radius: 6
                color: index === currentSlide ? "#ffffff" : "#666666"
                opacity: index === currentSlide ? 1.0 : 0.5
                
                Behavior on color {
                    ColorAnimation { duration: 300 }
                }
                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
            }
        }
    }
    
    // Smooth transitions
    Behavior on currentSlide {
        NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
    }
}

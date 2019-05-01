import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "MultimediaWidgets"
    Depends { name: "Qt"; submodules: ["core", "gui", "multimedia", "widgets"]}

    architecture: "x86_64"
    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/x86_64-linux-gnu/libQt5Multimedia.so.5.9.5", "/usr/lib/x86_64-linux-gnu/libQt5Widgets.so.5.9.5", "/usr/lib/x86_64-linux-gnu/libQt5Gui.so.5.9.5", "/usr/lib/x86_64-linux-gnu/libQt5Network.so.5.9.5", "/usr/lib/x86_64-linux-gnu/libQt5Core.so.5.9.5", "pthread", "pulse-mainloop-glib", "pulse", "glib-2.0"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5MultimediaWidgets"
    libNameForLinkerRelease: "Qt5MultimediaWidgets"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/x86_64-linux-gnu/libQt5MultimediaWidgets.so.5.9.5"
    cpp.defines: ["QT_MULTIMEDIAWIDGETS_LIB"]
    cpp.includePaths: ["/usr/include/x86_64-linux-gnu/qt5", "/usr/include/x86_64-linux-gnu/qt5/QtMultimediaWidgets"]
    cpp.libraryPaths: []
    
}

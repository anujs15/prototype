pragma Singleton
import QtQuick 2.15
import "dataset.js" as Fn

QtObject {

    property int currentIndex: 0
    property var activeKeys: ({})
    property var expectedSequence: []
    property int currentStep: 0
    property var keyColors: []
    property bool allkeys:true
    property int count:1
    property bool skipright:true

    property string resultText: ""
    property color resultColor: "white"
    property real resultOpacity: 0


    function resetSequence() {
        allkeys=true
        currentStep = 0
        activeKeys = {}
        keyColors = new Array(Fn.dataset[currentIndex].key.length).fill("white")
        expectedSequence = Fn.dataset[currentIndex].key
    }

    function checkKeyPress(event) {
        const currentKey = expectedSequence[currentStep]
        const isModifier = ["Ctrl", "Shift", "Alt"].includes(currentKey)
        let keyMatch = false

        if (currentKey === "Ctrl") {
            keyMatch = event.modifiers & Qt.ControlModifier
        } else if (currentKey === "Shift") {
            keyMatch = event.modifiers & Qt.ShiftModifier
        } else if (currentKey === "Alt") {
            keyMatch = event.modifiers & Qt.AltModifier
        } else {
            keyMatch = event.key === currentKey.charCodeAt(0)
        }

        return keyMatch && !activeKeys[currentKey]
    }

    function handleKeyPress(event) {
        if (event.isAutoRepeat) return

       if (event.key === Qt.Key_Escape)
        {
            if(stackView) stackView.pop()
            event.accepted=true
            return
        }

         else if(event.key === Qt.Key_Enter || event.key===Qt.Key_Return) resetSequence()
         else if(event.key === Qt.Key_Right && currentStep==0) skipRight()
          else if(event.key === Qt.Key_Left && currentStep==0) skipLeft()

        else{
               const currentKey = expectedSequence[currentStep]

              if (checkKeyPress(event)) {

                     activeKeys[currentKey] = true
                      var newColors=keyColors.slice()
                      newColors[currentStep] = "green"
                      keyColors=newColors
                       currentStep++

                     if (currentStep === expectedSequence.length) {
                              showResult(allkeys)
                            nextShortcutTimer.start()

                       }

                     event.accepted = true
              }

             else  {
                       activeKeys[currentKey] = true
                       newColors=keyColors.slice()
                        newColors[currentStep] = "red"
                        keyColors=newColors
                        currentStep++
                        allkeys=false
                     if (currentStep === expectedSequence.length) {
                            showResult(allkeys)
                        }

                   }
        }
    }

    function handleKeyRelease(event) {
        const releasedKey = Object.keys(activeKeys).find(key =>
            (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
            (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
            (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
            (event.key === key.charCodeAt(0))
        )

             if((event.key=== Qt.Key_Right || event.key=== Qt.Key_Left) && currentStep==0)
             {
                 resetSequence()
             }

            else if(event.key === Qt.Key_Enter || event.key===Qt.Key_Return)
             {
                 resetSequence()
             }

          else if (releasedKey) {

               delete activeKeys[releasedKey]
                if (currentStep > 0 && currentStep < expectedSequence.length) {
                   showResult(false)
                   currentStep = 0
                   resetSequence()
            }
        }
        else{
               delete activeKeys[releasedKey]
                 showResult(false)
                 currentStep =0
                resetSequence()
            }
    }

   property Timer  nextShortcutTimer: Timer{
        id: nextShortcutTimer
        interval: 1500
        onTriggered: advanceShortcut()
    }

     property Timer errorResetTimer:Timer {
        id: errorResetTimer
        interval: 1000
        onTriggered: resultDisplay.opacity = 0
    }

    function skipRight()
    {
        currentIndex = (currentIndex + 1)<Fn.dataset.length?currentIndex + 1:Fn.dataset.length
        count=(((count + 1) <Fn.dataset.length+1))?count+1:Fn.dataset.length
         resetSequence()
    }

    function skipLeft()
    {
        currentIndex = (currentIndex - 1)>0?currentIndex - 1:0
        count=(count - 1)>0?count-1:1
        resetSequence()
    }

    function advanceShortcut() {

          currentIndex = (currentIndex + 1) % Fn.dataset.length
          count=(((count + 1) % (Fn.dataset.length+1))==0)?1:count+1

        resetSequence()
        resultDisplay.opacity = 0
    }

    function showResult(success) {
        resultDisplay.text = success ? "✓ Correct!" : "✗ Try Again!"
        resultDisplay.color = success ? "green" : "red"
        resultDisplay.opacity = 1
        if (!success) errorResetTimer.restart()
    }
}





class Machine {
    def next(List<List<Object>> inputOutputPairs) {
        def transitions = [0: [:]]
        def outputTransitions = [0: [:]]
        def curstate = 0
        def stack = [] as Stack
        def i = 0
        while (i < inputOutputPairs.size()) {
            println "$i $stack"
            println "    0   1"
            for (k in 0..<(transitions.size())) {
                def pp = { a, j -> def z = a[k][j]; z == null ? '?' : z }
                println "${curstate == k ? '*' : ' '}$k ${pp transitions, 0}/${pp outputTransitions, 0} ${pp transitions, 1}/${pp outputTransitions, 1}"
            }
            def (input, output) = inputOutputPairs[i]
            println "input $input output $output"
            println ""
            switch (outputTransitions[curstate][input]) {
                case output:
                    curstate = transitions[curstate][input]
                    break
                case null:
                    outputTransitions[curstate][input] = output
                    def newState = transitions[curstate][input]
                    if (newState == null) {
                        stack.push([i, curstate, 1])
                        transitions[curstate][input] = 0
                        curstate = 0
                        break
                    } else {
                        curstate = newState
                        break
                    }
                default:
                    println "pop"
                    def (newi, newCurState, newDestState) = stack.pop()
                    while (newDestState == transitions.size()) {
                        newInput = inputOutputPairs[newi][0]
                        transitions[newCurState].remove(newInput)
                        outputTransitions[newCurState].remove(newInput)
                        if (stack.size() > 0) {
                            println "pop"
                            def temp = stack.pop()
                            newi = temp[0]
                            newCurState = temp[1]
                            newDestState = temp[2]
                        } else {
                            println "Adding state"
                            def size = transitions.size()
                            transitions[size] = [:]
                            outputTransitions[size] = [:]
                            newDestState = 0
                        }
                    }
                    stack.push([newi, newCurState, newDestState + 1])
                    i = newi
                    def (newInput, newOutput) = inputOutputPairs[i]
                    transitions[newCurState][newInput] = newDestState
                    outputTransitions[newCurState][newInput] = newOutput
                    curstate = newDestState
            }
            i++
    }
    [transitions, outputTransitions]
  }
}

new Machine().next(
  [
    [0,'F'],//0
    [1,'S'],//1
    [0,'F'],//2
    [0,'F'],//3
    [1,'S'],//4
    [1,'S'],//5
    [0,'F'],//6
    [1,'S'],//7
    [0,'F'],//8
    [0,'F'],//9
    [1,'S'],//10
    [0,'S'],//11
    [1,'S'],//12
    [1,'S'],//13
    [0,'F'],//14
    [0,'F'],//15
    [0,'F'],//16
    [1,'S'],//17
    [0,'F'],//18
  ])

/*

transitions [0:[0:2, 1:0], 1:[1:0, 0:1], 2:[0:1, 1:0]]
outputTransitions [0:[0:F, 1:S], 1:[1:S, 0:S], 2:[0:F, 1:S]]
curstate 1
stack [[0, 0, 1], [1, 0, 3], [3, 2, 2], [4, 2, 2], [10, 1, 2]]

     0.F
    _ 0
     /|\
 1.S/   \ 1.S
   / 0.S_\|
  2<----->1
     1.S   0.F

i     012345678901234567
state 0011120011121200011
input 010011010010110010
outpt FSFFSSFSFFSSSSFFSF
*/

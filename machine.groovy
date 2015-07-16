class Machine {
  def next(inputOutputPairs) {
    def transitions = [0:[:]]
    def outputTransitions = [0:[:]]
    def curstate = 0
    def stack = [] as Stack
    def i = 0
    while(i < inputOutputPairs.size) {
      println "$i $stack"
      println "    0   1"
      for (k in 0..<(transitions.size())) {
        println "${curstate == k?'*':' '}$k ${def z = transitions[k][0]; z == null ? '?' : z}/${def z = outputTransitions[k][0]; z == null ? '?' : z} ${def z = transitions[k][1]; z == null ? '?' : z}/${def z = outputTransitions[k][1]; z == null ? '?' : z}"
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
            def (newInput, newOutput) = inputOutputPairs[newi]
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
          i = newi - 1
          curstate = newCurState
          transitions[curstate][input] = newDestState
          outputTransitions[curstate][input] = output
      }  
      i++
    }
    [transitions, outputTransitions]
  }
}

new Machine().next(
  [
    [0,'F'],
    [1,'S'],
    [0,'F'],
    [0,'F'],
    [1,'S'],
    [1,'S'],
    [0,'F'],
    [1,'S'],
    [0,'F'],
    [0,'F'],
    [1,'S'],
    [0,'S'],
    [1,'S'],
    [1,'S'],
    [0,'F'],
    [0,'F'],
    [0,'F'],
    [1,'S'],
    [0,'F'],
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

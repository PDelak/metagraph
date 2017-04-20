import macros

macro getOperatorLinkRep():stmt =    
  let ast = parseStmt("""  
    proc `->` [A,B](a:A, b:B):void = 
      var x = 123
      echo "reer"
      echo x 
  """)
  result = ast

macro getOperatorLinkCycleRep():stmt =    
  let ast = parseStmt("""  
    proc `<->` [A,B](a:A, b:B):void = 
      var x = 123
      echo "reer"
      echo x 
  """)
  result = ast

macro defineGraph(body : stmt) : stmt =
  echo "defining graph"
  for s in body:
    echo s.kind
  
  quote do: 
    `body`
    proc addVertex():void = echo "addVertex"
    proc removeVertex(i:int):void = echo i
    proc addEdge[A,B](a:A, b:B) = discard
    macro removeEdge(str : string) : stmt = echo str
    getOperatorLinkRep
    getOperatorLinkCycleRep


template defineEdge (a, b: untyped): untyped = discard
template defineVertex (a: untyped): untyped = discard
template defineType(a: untyped): untyped = discard

type A = object
type B = object

# schema/type definition
defineGraph:
    
    defineType:
       type C = object
         i:int
    defineType:
       type D = object
         s:string

    defineVertex(A)
    defineVertex(B)
    defineVertex(C)
    defineEdge(A,B)
    defineEdge(B,A)


var a : A
var b : B

addVertex()
removeVertex(1)

addEdge(a,b)
a <-> b
a -> b

removeEdge "hello"


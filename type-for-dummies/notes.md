- The stages of Programming 

1. Write a program 
  > hello.c
  > printf("Hello!");

2. Compile the program (to get an .exec)
  

 > gcc -o hello.exec hello.c
 > ; gives hello.exec

3. Run the program 
  > ./hello.exec
  > Hello! 
  
  


- Programs have errors! 

Google chrome is an .exec 
That crashes

https://www.google.com/search?biw=1435&bih=681&tbm=isch&sa=1&ei=ZeoRWoaHGIGTmQGDk4qwDA&q=crash+message&oq=crash+message&gs_l=psy-ab.3..0j0i5i30k1l4j0i24k1l2.83915.83915.0.84201.1.1.0.0.0.0.74.74.1.1.0....0...1.1.64.psy-ab..0.1.74....0.he5kszenZ-g#imgrc=f6hEeIqbiI84xM:

- Types: Sanity checks that prevent errors before .exec is generated!
1 + "Hello!" 
Error! 
1 + 2 
OK! 

- Example: 

  > printf(1 + "Hello!");
  > 1. > 1Hello!
  > 2. > Hello!
  > 3. > ello!
  > 4. 1+Hello!

Unexpected, correct?


- Types 
Types catch these unexpected behaviors early (at compile time)!

- Let's design a type system!
1. Use Types to Clasify Data (statements)

1 + "Hello!" 

1 : Int 
"Hello!" : String 

2. Define How Data Are combined (rules)
If e1 : Int and e2 : Int, then 
e1 + e2 : Int 

where e1 e2 are variables


e1 :: Int 
e2 :: Int 
----------
e1 + e2 : Int 

e.g., e1 := 1, e2 := 2
e.g., e1 := 1+2, e2 := 2
e.g., e1 := 1, e2 := "Hello!"


- Type System Design
Add rules (+, )

What prevents me from adding bad rules?

we like to name things
Goal 1: Catch all possible errors! [Sound]
(Just reject everything!)

Goal 2: Accept all correct programs! [Complete]
(Just accept everything!)

- Soundness
If e has a type, then it will not crash!
If e has a type, then it return a value !

(1+1)+2 is an expression
4 is an value

(1+1)+2 `returns` 4 
(1+1)+2
 -> 2 + 2 
 -> 4 
(1+1)+2 ->* 4 



If e has a type, then e ->* 4 !
If e:t, then e ->* 4 !


At compile type we only have e! 
And we want to check that e ->* v. 

- Preservation 
If e1 -> e2 and e1:t, then e2:t.

(1+1)+2 : Int, progress there exists 
 -> 2 + 2: Int  
 -> 4 



- Progress 
If e1:t, then either e1 is a value or e1 -> e2.




Example
-------

(1+1)+2 : Int, progress there exists 
 -> 2 + 2: Int  
 -> 4 
(1+1)+2 ->* 4

Generally, 
e1:t -> e2:t -> ... -> en:t

Soundness
e : t & e ~> v, then v:t


- The stages of Programming 

1. Write a program e
  > hello.c
  > printf("Hello!");

2. Compile the program (to get an .exec)
  

 > gcc -o hello.exec hello.c
 > ; gives hello.exec

3. Run the program 
  > ./hello.exec
  > Hello! 
  
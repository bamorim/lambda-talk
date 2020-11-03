---
marp: true
theme: dracula
---

# Learn You Some Lambda Calculus
## Bernardo Amorim

---

![bg](#fff)
![bg fit](../images/haskell.svg)

---

![bg](#fff)
![bg fit](../images/clojure.png)

---

![bg](#fff)
![bg fit](../images/racket.svg)

---

# Similarities?

* λ - Lambda
* Functional Programming Languages

<!-- Have you seen what these languages have in common? -->
<!-- The Greek Letter Lambda is on their logos. -->
<!-- And also, they all position themselves as functional programming languages. -->

---

# Anonymous Functions

| Python | Ruby |
| - | - |
| `lambda x: x` | `lambda { |x| x }` |

<!-- If you go to Python or Ruby, for example, you use the keyword `lambda` in order to create an anonymous functions. -->

---

# λ ≈ Functional Programming?
# λ ≈ Anonymous Functions?

<!-- So, why is the lambda letter is related to functional programming? -->

---

![bg right fit](../images/church-1936a.png)

## Alonzo Church

![inline](../images/church.jpg)

<!-- That dates back to 1936, when Alonzo Church created this thing called lambda calculus in order to formalize computability. -->


---

![bg fit](../images/turing-1936.png)
![bg fit](../images/church-1936a.png)
<!-- Funny enough, it was published mostly at the same time that the famous paper from Alan Turing that introduced Turing Machines, which was later proven to be equivalent in terms on what they can compute. -->

---

# Turing Completeness
## and the Church-Turing thesis

<!-- Defines computability on what a Turing Machine or Lambda Calculus can compute. So a system is said to be turing-complete if it can implement a turing machine (or a lambda calculus reductor). -->

---

# Programming Challenge

## Weird sub-set of JS

#### Or python, ruby, etc..

---

# Weird sub-set of JS

## Valid **terms** can be:

* Variable names such as `x`, `y`, or `my_variable`
* Anonymous functions definitions with exactly one argument like `x => BODY` where `BODY` is also a valid **term**.
* Application of functions, like `A(B)` where both `A` and `B` are valid **terms**.
* No use of externally defined variables or functions

---

# Weird sub-set of JS

```javascript
x => x
x => x(x)
(x => x)(x => x)
f => x => x
f => x => f(x)
f => x => f(f(f(f(x))))
```

---

# Weird sub-set of Python

```python
lambda x: x
lambda x: x(x)
(lambda x: x)(lambda x: x)
lambda f: lambda x: x
lambda f: lambda x: f(x)
lambda f: lambda x: f(f(f(f(x))))
```

---

# Weird sub-set of Ruby

```ruby
lambda { |x| x }
lambda { |x| x.(x) }
lambda { |x| x }.(lambda { |x| x })
lambda { |f| lambda { |x| x } }
lambda { |f| lambda { |x| f.(x) } }
lambda { |f| lambda { |x| f.(f.(f.(f.(x)))) } }
```

---

# Weird sub-set of JS

This is **Turing-Complete**

---

# Here is a factorial function.

---

```javascript
(
  f => (x => x(x))(x => f(y => x(x)(y)))
)(
  fact => n => (
    b => tf => ff => b(tf)(ff)(b)
  )(
    (n => n(a => b => f => f)(t => f => t))(n)
  )(
    a => f => x => f(x)
  )(
    a => (
      n => m => f => x => n(m(f))(x)
    )(
      n
    )(
      fact((n => f => x => n(g => h => h(g(f)))(a => x)(u => u))(n))
    )
  )
)
```

---

# Encoding and Decoding

```javascript
toNumber(
  factorial(
    fromNumber(5)
  )
)
```

<!--
Open console and show it working
Since this thing can only work with functions, we cannot put JS Numbers into that, so we need some kind of encoding and decoding mechanism, which I'll assume we have for now (we actually do)
-->

---

# OK, What about λ-calculus?

---

# λ-calculus

* A really small programming language
* Consisted of only anonymous curried functions

---

# λ-calculus syntax

| Constructor | Lambda |
| --- | --- |
| Variable | `x`, `y` |
| Abstraction | `λx. BODY` |
| Application | `A B` |

---

# Application is left associative

## a b c = (a b) c

## a b c ≠ a (b c)

---

# Remember this?

```javascript
x => x
x => x(x)
(x => x)(x => x)
f => x => x
f => x => f(x)
f => x => f(f(f(f(x))))
```

---

# In λ-calculus syntax

```
λx. x
λx. x x
(λx. x) (λx. x)
λf. λx. x
λf. λx. f x
λf. λx. f (f (f (f x)))
```

---

# From λ to Factorial

---

# From λ to Factorial

```javascript {1,2,4-5}
function fact(n) {
  if (n === 0) {
    return 1
  } else {
    return n * fact(n-1)
  }
}
```

<!--
* Encode Natural Numbers
* Encode Booleans
* Is Zero?
* If/Then/Else
* Multiplication
* Predecessor (n-1; subtraction or just predecessor)
* Recursion
-->

---

# So we need

- ☐ Encoding for Booleans
- ☐ Encoding for Natural Numbers
- ☐ Function to check if number is zero
- ☐ Multiplication
- ☐ Predecessor
- ☐ If/Then/Else
- ☐ Recursion

---

# Encoding Booleans

---

## That is: encode **True** and **False**

#### P.S.: There are infinite ways of doing this

---

# What are booleans used for?

---

# Branching
## Pick one of two paths

---

# `λ?. ???`

---

# `λthen. λelse. ???`

---

# True: `λthen. λelse. then`
# False: `λthen. λelse. else`

---

# Church Booleans

---

# In Javascript

```javascript
const tru = t => f => t
const fals = t => f => f
```

---

# Operations on Booleans

---

# Not Function

---

# Not Function

| `a` | `not a` |
| --- | --- |
| `true` | `false` |
| `false` | `true` |

---

# Not Function

```javascript
const not = a ? false : true
```

---

# Not Function

## `λa. a FALSE TRUE`

---

# Not Function

```javascript
const not = b => b(fals)(tru)
```

---

# Other Functions

---

# Other Functions

```javascript
const and = a => b => a ? b : false
const or = a => b => a ? true : b
const xor = a => b => a ? b : (b ? false : true)
```

---

# Other Functions

```javascript
const and = a => b => a(b)(fals)
const or = a => b => a(tru)(b)
const xor = a => b => a(b)(b(fals)(tru))
```

---

# What we have so far

- ☑ Encoding for Booleans
- ☐ Encoding for Natural Numbers
- ☐ Function to check if number is zero
- ☐ Multiplication
- ☐ Predecessor
- ☐ If/Then/Else
- ☐ Recursion

---

# Encoding Natural Numbers

---

# That is: encode **0**, **1**, **2**, ...

#### P.S.: There are also infinite ways of doing this

---

# What natural numbers are used for?

---

# Counting things

---

# Church Numerals

## Count the number of times a function is applied to a given input

### `N => λf. λx. F_APPLIED_TO_X_N_TIMES`

---

| Number | Encoding |
| :---: | --- |
| **0** | `λf. λx. x` |
| **1** | `λf. λx. f x` |
| **2** | `λf. λx. f (f x)` |
| **3** | `λf. λx. f (f (f x))` |
| **4** | `λf. λx. f (f (f (f x)))` |

---

# Constructing Natural Numbers

* We need zero
* And a way to get N+1 given N (successor)

---

# Zero

## `λf. λx. x`

---

# Zero

```javascript
const zero = f => x => x
```

---

# Successor Function

## `λn. ???`

<!--
This is a function that receives a number and should return this number + 1
But we know the "form" of a function
-->

---

# Successor function

## `λn. λf. λx. ???`

<!--
Now what the internal function should return is, if `n` receives a function and an input and applies the function to the input *N* times,
then we need to apply `f` *N+1* times to `x`.
-->

---

# Successor function

## `λn. λf. λx. ??? (n f x)`

<!--
Well, `(n f x)` will already apply `f` to `x` *N* times
Then we just need to apply one more time.
-->

---

# Successor function

## `λn. λf. λx. f (n f x)`

---

# Successor Function

```javascript
const succ = n => f => x => f(n(f)(x))
```

---

# Let's try it out

```javascript
const one = succ(zero)
const two = succ(one)
const three = succ(two)
const hundred = succ(fromNumber(10))
```

---

# What we have so far

- ☑ Encoding for Booleans
- ☑ Encoding for Natural Numbers
- ☐ Function to check if number is zero
- ☐ Multiplication
- ☐ Predecessor
- ☐ If/Then/Else
- ☐ Recursion

---

# Functions on Natural Numbers

- Is Zero
- Multiplication
- Predecessor

* Sorry, only 30 minute talk :cry:

---

# Is Zero
`λn. n (λx. FALSE) TRUE`

# Multiplication
`λa. λb. (λf. λx. b (a f) x)`

# Predecessor Function
`λn. λf. λx. n (λg. λh. h (g f)) (λu. x) (λu. u)`

---

```javascript
const isZero = n => n(x => fals)(tru)
const mul = a => b => (f => x => b(a(f))(x))
const pred = n => f => x => n(g => h => h(g(f)))(y => x)(u => u)
```

---

# What we have so far

- ☑ Encoding for Booleans
- ☑ Encoding for Natural Numbers
- ☑ Function to check if number is zero
- ☑ Multiplication
- ☑ Predecessor
- ☐ If/Then/Else
- ☐ Recursion

---

# If Then Else

* Isn't it just applying booleans to the branches?
* No, because Javascript is **eagerly evaluated**
* So we'll need to do one trick

---

## `λb. λthen. λelse. b then else ANY_VALUE`

---

```javascript
const ifte = b => t => e => b(t)(e)(b)

// Example usage
ifte(myBool)(b => thenThis)(b => elseThis)
```

---

# What we have so far

- ☑ Encoding for Natural Numbers
- ☑ Encoding for Booleans
- ☑ Function to check if number is zero
- ☑ Multiplication
- ☑ Predecessor
- ☑ If/Then/Else
- ☐ Recursion


---

# Recursion

---

# The problem with recursion

* All functions are anonymous
* Therefore, we cannot refer a function to itself by name
* Solution: **Abstract yourself**

---

# Abstract Yourself

* `λx. ?CALL_MY_SELF?`
* `λmyself. λx. myself x`

---

```
λfact. λn.
  IFTE
    (IS_ZERO n)
    (λx. ONE)
    (λx. (MUL n (fact (PRED n))))
```

---

```javascript
const absFact = fact => n => 
  ifte(isZero(n))(
    (t) => one
  )(
    (e) => mul(n)(fact(pred(n)))
  )
```

---

# Fixed-point combinators


* Must have the property:
  ```
  fix f = f (fix f)
  ```
* Which if you expand once, you have:
  ```
        = f (f (fix f))
  ```
* And if you keep expanding:
  ```
        = f (f (f (... (f (fix f)) ...)))
  ```
* Good news: there is also infinite of these

---

# Y-Combinator

`Y = λf (λx. f (x x)) (λx. f (x x)))`

---

# In Javascript

```javascript
// Can't I just do
const Y = f => (x => f(x(x)))(x => f(x(x)))

// And apply
const fact = Y(absFact)

// And use
fact(...)
```

---

# Z-Combinator

* Works in eagerly evaluated environments
* Trick is similar to what we've done in `ifte`
* Defined as: `Z = λf. (λx. x x) (λx. f (λy. x x y))`

---

```javascript
const Z = f => (x => x(x))(x => f(y => x(x)(y)))
const fact = Z(absFact)
toNumber(fact(fromNumber(3)))
toNumber(fact(fromNumber(4)))
toNumber(fact(fromNumber(5)))
```

---

# Key Takeaways

- Lambda Calculus is about functions and functions all the way down
- And you can compute anything* with only that
- It is the theory behind functional programming languages such as Haskell

---

# Thanks Folks!

![inline](../images/qrcode.svg)

[github.com/bamorim/lambda-talk](https://github.com/bamorim/lambda-talk)
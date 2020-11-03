const factorial = (f => (x => x(x))(x => f(y => x(x)(y))))(fact => n => (b => tf => ff => b(tf)(ff)(b))((n => n(a => b => f => f)(t => f => t))(n))(a => f => x => f(x))(a => (n => m => f => x => n(m(f))(x))(n)(fact((n => f => x => n(g => h => h(g(f)))(a => x)(u => u))(n)))))

// Numbers
// We define this first because of the example

const zero = f => x => x
const succ = n => f => x => f(n(f)(x))
const toNumber = n => n((x) => x + 1)(0)
const fromNumber = jsN => [...Array(jsN)].reduce((x) => succ(x), zero)

const tru = t => f => t
const fals = t => f => f
tru("This if true")("This if false")
fals("This if true")("This if false")

const not = b => b(fals)(tru)
not(tru)
not(fals)

const and = a => b => a(b)(fals)
and(tru)(tru)
and(tru)(fals)
and(fals)(tru)
and(fals)(fals)

const one = succ(zero)
const two = succ(one)
const three = succ(two)
const hundred = succ(fromNumber(99))

toNumber(zero)
toNumber(one)
toNumber(two)
toNumber(three)
toNumber(hundred)

const isZero = n => n(x => fals)(tru)
const mul = n => m => f => x => n(m(f))(x)
const pred = n => f => x => n(g => h => h(g(f)))(y => x)(u => u)

isZero(zero)
toNumber(mul(fromNumber(5))(fromNumber(10)))
toNumber(pred(fromNumber(99)))

const ifte = b => t => e => b(t)(e)(b)

const absFact = fact => n => 
  ifte(isZero(n))(
    (t) => one
  )(
    (e) => mul(n)(fact(pred(n)))
  )

const Z = f => (x => x(x))(x => f(y => x(x)(y)))
const fact = Z(absFact)
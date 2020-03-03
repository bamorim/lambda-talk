id = fn x -> x end
id.(true)
true! = fn t -> fn _ -> t end end
false! = fn _ -> fn f -> f end end
true!.("This if true").("This if false")
false!.("This if true").("This if false")
lambda_to_bool = fn a -> a.(true).(false) end
lambda_to_bool.(true!)
lambda_to_bool.(false!)
not! = fn b -> b.(false!).(true!) end
true! |> not!.() |> lambda_to_bool.()
false! |> not!.() |> lambda_to_bool.()
and! = fn a -> fn b -> a.(b).(false!) end end
and!.(true!).(true!) |> lambda_to_bool.()
and!.(true!).(false!) |> lambda_to_bool.()
and!.(false!).(true!) |> lambda_to_bool.()
and!.(false!).(false!) |> lambda_to_bool.()
zero = fn _f -> fn x -> x end end
succ = fn n -> fn f -> fn x -> f.(n.(f).(x)) end end end
one = succ.(zero)
two = succ.(succ.(zero))
lambda_to_number = fn n -> n.(&(&1 + 1)).(0) end
number_to_lambda = fn
  0 -> zero
  n -> Enum.reduce(1..n, zero, fn _, x -> succ.(x) end)
end
lambda_to_number.(zero)
lambda_to_number.(one)
lambda_to_number.(two)
lambda_to_number.(succ.(two))
10 |> number_to_lambda.() |> succ.() |> lambda_to_number.()
add = fn n -> fn m -> m.(succ).(n) end end
zero |> add.(one).() |> lambda_to_number.()
one |> add.(one).() |> lambda_to_number.()
two |> add.(two).() |> lambda_to_number.()
mul = fn n -> fn m -> m.(add.(n)).(zero) end end
mul.
  (number_to_lambda.(5)).
  (number_to_lambda.(10)) |> lambda_to_number.()
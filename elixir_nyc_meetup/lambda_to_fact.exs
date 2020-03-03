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
is_zero = fn n -> n.(fn _ -> false! end).(true!) end
zero |> is_zero.() |> lambda_to_bool.()
one |> is_zero.() |> lambda_to_bool.()
two |> is_zero.() |> lambda_to_bool.()
ifte = fn b -> fn t -> fn e -> b.(t).(e).(b) end end end
ifte.(true!).(fn _ -> true end).(fn _ -> false end)
ifte.(false!).(fn _ -> true end).(fn _ -> false end)
mul = fn a -> fn b -> fn f -> fn x ->
  b.(a.(f)).(x)
end end end end
mul.
  (number_to_lambda.(5)).
  (number_to_lambda.(10)) |> lambda_to_number.()
pred = fn n -> fn f -> fn x ->
  n.(fn g -> fn h -> h.(g.(f)) end end).(fn _ -> x end).(fn u -> u end)
end end end
10 |> number_to_lambda.() |> pred.() |> lambda_to_number.()
abs_fact = fn fact -> fn n ->
  ifte.(is_zero.(n)).(
    fn _ -> one end
  ).(
    fn _ -> mul.(n).(fact.(pred.(n))) end
  )
end end
0 |> number_to_lambda.() |> abs_fact.(id).() |> lambda_to_number.()
1 |> number_to_lambda.() |> abs_fact.(id).() |> lambda_to_number.()
1 |> number_to_lambda.() |> abs_fact.(abs_fact.(id)).() |> lambda_to_number.()
2 |> number_to_lambda.() |> abs_fact.(abs_fact.(id)).() |> lambda_to_number.()
3 |>
number_to_lambda.() |>
abs_fact.(abs_fact.(abs_fact.(abs_fact.(id)))).() |>
lambda_to_number.()
4 |>
number_to_lambda.() |>
abs_fact.(abs_fact.(abs_fact.(abs_fact.(id)))).() |>
lambda_to_number.()
faux_fact = fn n -> abs_fact.(n.(abs_fact).(id)).(n) end
3 |> number_to_lambda.() |> faux_fact.() |> lambda_to_number.()
4 |> number_to_lambda.() |> faux_fact.() |> lambda_to_number.()
5 |> number_to_lambda.() |> faux_fact.() |> lambda_to_number.()
z_combinator = fn f ->
  (fn x -> x.(x) end).(
    fn x -> f.(fn y -> x.(x).(y) end) end
  )
end
fact = z_combinator.(abs_fact)
3 |> number_to_lambda.() |> fact.() |> lambda_to_number.()
4 |> number_to_lambda.() |> fact.() |> lambda_to_number.()
5 |> number_to_lambda.() |> fact.() |> lambda_to_number.()
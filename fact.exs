zero = fn _f -> fn x -> x end end
succ = fn n -> fn f -> fn x -> f.(n.(f).(x)) end end end
lambda_to_number = fn n -> n.(&(&1 + 1)).(0) end
number_to_lambda = fn
  0 -> zero
  n -> Enum.reduce(1..n, zero, fn _, x -> succ.(x) end)
end
fact = (fn f -> (fn x -> x.(x) end).(fn x -> f.(fn y -> x.(x).(y) end) end) end).(fn fact -> fn n -> (fn b -> fn tf -> fn ff -> b.(tf).(ff).(b) end end end).((fn n -> n.(fn _ -> fn _ -> fn f -> f end end end).(fn t -> fn _ -> t end end) end).(n)).(fn _ -> fn f -> fn x -> f.(x) end end end).(fn _ -> (fn n -> fn m -> fn f -> fn x -> n.(m.(f)).(x) end end end end).(n).(fact.((fn n -> fn f -> fn x -> n.(fn g -> fn h -> h.(g.(f)) end end).(fn _ -> x end).(fn u -> u end) end end end).(n))) end) end end)
5 |>
number_to_lambda.() |>
fact.() |>
lambda_to_number.()

-module(task).
-export([find_common/1]).

find_common([]) -> io:fwrite("No common elements");
find_common(Array) ->
  [{Element, _} | Rest] = through_all_array(lists:sort(Array)),
  RestLen = lists:flatlength(Rest),
  if
    (RestLen == 0) -> io:fwrite("The most common element is: ~w~n", [Element]);
    true -> find_common([])
  end.

through_all_array(Array) ->
  {Element, Rest} = count_first_common(Array),
  through_all_array(Rest, [Element]).

through_all_array([], Element) -> Element;
through_all_array(Array, [{CurElement, CurNbr} | RestResult]) ->
  {{NewElement, NewNum}, Rest} = count_first_common(Array),
  if
    (CurNbr == NewNum) -> through_all_array(Rest, [{NewElement, NewNum}, {CurElement, CurNbr} | RestResult]);
    (CurNbr > NewNum) -> through_all_array(Rest, [{CurElement, CurNbr} | RestResult]);
    (CurNbr < NewNum) -> through_all_array(Rest, [{NewElement, NewNum}]);
    true -> through_all_array(Rest, {CurElement, CurNbr})
  end.

count_first_common([First | Rest]) -> count_first_common(Rest, {First, 1}).
count_first_common([], Result) -> {Result, []};
count_first_common([First | Rest], {Element, Number}) when First =:= Element ->
  count_first_common(Rest, {Element, Number + 1});
count_first_common(Array, Result) -> {Result, Array}.


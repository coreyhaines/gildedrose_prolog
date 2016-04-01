% item(Name, Quality, SellIn)
item(apple, 10, 1).
item(pear, 3, 5).
item(peach, 1, 5).
item(brie, 10, 2).

improvingItem(brie).

availableProducts(Name, Quality) :-
  itemQuality(Name, Quality),
  Quality > 0.

guardQuality(Quality, GuardedQuality) :-
  Quality > 50,
  GuardedQuality is 50;
  Quality =< 50,
  GuardedQuality is Quality.

itemQuality(Name, Quality) :-
  item(Name, OriginalQuality, _),
  improvingItem(Name),
  daysPassed(DaysPassed),
  DaysPassed =< SellIn,
  guardQuality(OriginalQuality + DaysPassed, Quality).

itemQuality(Name, Quality) :-
  item(Name, OriginalQuality, SellIn),
  not(improvingItem(Name)),
  daysPassed(DaysPassed),
  DaysPassed =< SellIn,
  Quality is OriginalQuality - DaysPassed.

itemQuality(Name, Quality) :-
  item(Name, OriginalQuality, SellIn),
  not(improvingItem(Name)),
  daysPassed(DaysPassed),
  DaysPassed > SellIn,
  Quality is OriginalQuality - SellIn - (2*(DaysPassed-SellIn)).

:- dynamic day_passed/1.
day_has_passed() :-
  asserta(day_passed(1)).

sum(List, Sum) :-
  sumRec(List, 0, Sum).
sumRec([], Value, Value).
sumRec([H|T], Value, Accum) :-
  sumRec(T, Value, OldAccum),
  Accum is OldAccum + H.

daysPassed(Count) :-
  findall(Number, day_passed(Number), DaysPassed),
  sum(DaysPassed, Count).

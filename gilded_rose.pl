% item(Name, Quality, SellIn)
item(apple, 10, 1).
item(pear, 3, 5).
item(peach, 1, 1).
item(brie, 10, 2).

improvingItem(brie).

products(Name, Quality, DaysPassed) :-
  itemQuality(Name, Quality, DaysPassed).

guardQuality(Quality, GuardedQuality) :-
  Quality > 50, GuardedQuality is 50;
  Quality < 0, GuardedQuality is 0;
  Quality >= 0, Quality =< 50, GuardedQuality is Quality.

itemQuality(Name, Quality, DaysPassed) :-
 item(Name, OriginalQuality, _),
 improvingItem(Name),
 guardQuality(OriginalQuality + DaysPassed, Quality).

itemQuality(Name, Quality, DaysPassed) :-
  item(Name, OriginalQuality, SellIn),
  not(improvingItem(Name)),
  DaysPassed =< SellIn,
  guardQuality(OriginalQuality - DaysPassed, Quality).

itemQuality(Name, Quality, DaysPassed) :-
  item(Name, OriginalQuality, SellIn),
  not(improvingItem(Name)),
  DaysPassed > SellIn,
  guardQuality(OriginalQuality - SellIn - (2*(DaysPassed-SellIn)), Quality).

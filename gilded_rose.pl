% item(Name, Quality, SellIn)
item(apple, 10, 1).
item(pear, 3, 5).
item(peach, 1, 1).
item(brie, 10, 2).
item(sulfras, 10, 0).

improvingItem(brie).
legendaryItem(sulfras).

products(Name, Quality, DaysPassed) :-
  itemQuality(Name, Quality, DaysPassed).

guardQuality(Quality, GuardedQuality) :-
  Quality > 50, GuardedQuality is 50;
  Quality < 0, GuardedQuality is 0;
  Quality >= 0, Quality =< 50, GuardedQuality is Quality.

itemQuality(Name, Quality, _) :-
 item(Name, OriginalQuality, _),
 legendaryItem(Name),
  Quality is OriginalQuality.

itemQuality(Name, Quality, DaysPassed) :-
 item(Name, OriginalQuality, _),
 improvingItem(Name),
 guardQuality(OriginalQuality + DaysPassed, Quality).

itemQuality(Name, Quality, DaysPassed) :-
  item(Name, OriginalQuality, SellIn),
  not(improvingItem(Name)),
  not(legendaryItem(Name)),
  DaysPassed =< SellIn,
  guardQuality(OriginalQuality - DaysPassed, Quality).

itemQuality(Name, Quality, DaysPassed) :-
  item(Name, OriginalQuality, SellIn),
  not(improvingItem(Name)),
  not(legendaryItem(Name)),
  DaysPassed > SellIn,
  guardQuality(OriginalQuality - SellIn - (2*(DaysPassed-SellIn)), Quality).

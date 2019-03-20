# Locales

We didn't really have any conventions in place before for organising the locale files which made it hard to know where to put/find translations.

The new convention is to have a one-to-one mapping. If we take the ChristmasMoneyPlanner as an example, in the ```set_meta_tags``` method we have a variable called ```christmas_money_planner.meta.title``` which would be found in ```/config/locales/christmas_money_planner.{locale}.yml```

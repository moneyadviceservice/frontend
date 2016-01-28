# Locales

We didn't really have any conventions in place before for organising the locale files which made it hard to know where to put/find translations.

The new convention is to have a one-to-one mapping. If we take the BabyCostCalculatorController as an example, in the deny_non_syndicates method we have a variable called ```controllers.baby_cost_calculator.deny_non_syndicates.article_id``` which would be found in ```/config/locales/controllers/baby_cost_calculator.{locale}.yml```

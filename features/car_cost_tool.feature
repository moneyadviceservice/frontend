Feature: View the Car Cost Tool
  As a visitor to the website
  I want to view the Car Cost Tool
  So I can see the costs involved in running a car

  @enable-car_cost_tool
  Scenario Outline: View the Car Cost Tool
    When I view the Car Cost Tool in <language>
    Then I should see the Car Cost Tool in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  @enable-car_cost_tool
  Scenario Outline: Translate the Car Cost Tool
    Given I view the Car Cost Tool in <original_language>
    When I translate the Car Cost Tool into <translated_language>
    Then I should see the Car Cost Tool in <translated_language>

  Examples:
    | original_language | translated_language |
    | English           | Welsh               |
    | Welsh             | English             |

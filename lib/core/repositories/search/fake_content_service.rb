module Core::Repositories
  module Search
    class FakeContentService
      def perform(query)
        search_results
      end

      private

      def search_results
        [
          {
            "id" => "manage-your-budget-after-redundancy",
            "type" => "action_plan",
            "title" => "Manage your budget after redundancy",
            "description" => "Use this step-by-step action plan to help you keep the household budget on track after redundancy."
          },
          {
            "id" => "new-baby-why-budget",
            "type" => "article",
            "title" => "New baby – why budget?",
            "description" => "If you find yourself saying that more and more, especially if there’s a new baby on the scene, it’s probably time to draw up a household budget and start planning your spending."
          },
          {
            "id" => "funeral-plans",
            "title" => "Funeral plans",
            "type" => "article",
            "description" => "A funeral plan is a way of paying for a future funeral today. Here are some things to bear in mind if you're thinking of taking one out."
          },
          {
            "id" => "how-to-make-your-money-go-further",
            "type" => "action_plan",
            "title" => "How to make your money go further",
            "description" => "Follow this action plan to help you save money around the home and when you’re out and about, making your hard-earned cash go that bit further."
          }
        ]
      end
    end
  end
end

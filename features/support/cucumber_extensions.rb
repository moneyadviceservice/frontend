module Cucumber
  module Ast
    class Feature # http://rubydoc.info/github/cucumber/cucumber/Cucumber/Ast/Feature
      def accept(visitor)
        return if Cucumber.wants_to_quit
        visitor.visit_comment(@comment) unless @comment.empty?
        visitor.visit_tags(@tags)
        visitor.visit_feature_name(@keyword, indented_name)
        visitor.visit_background(@background) if !@background.is_a?(EmptyBackground)
        @feature_elements.each do |feature_element|
          if with_and_without_javascript?(feature_element)
            visit_feature_element_twice(feature_element, visitor)
          else
            visitor.visit_feature_element(feature_element)
          end
        end
      end

      private
      def with_and_without_javascript?(feature_element)
        source_tag_names.include?('@with_and_without_javascript') ||
          feature_element.scenario_tags.map(&:name).include?('@with_and_without_javascript')
      end

      def visit_feature_element_twice(feature_element, visitor)
        line = feature_element.scenario_tags.map(&:line).first
        feature_element.scenario_tags.delete_if {|t| t.name == '@with_and_without_javascript'}

        visitor.visit_feature_element(feature_element)

        feature_element.scenario_tags << Gherkin::Formatter::Model::Tag.new('@javascript', line)
        feature_element.scenario_steps.force_invoke!
        feature_element.not_executed!
        feature_element.force_invoke! if feature_element.respond_to?(:force_invoke!)

        visitor.visit_feature_element(feature_element)
      end
    end

    class OutlineTable
      def force_invoke!
        @dunit = false
      end
    end

    class Examples
      def force_invoke!
        @outline_table.force_invoke!
      end
    end

    class Scenario
      def scenario_tags
        @tags.tags
      end

      def not_executed!
        @executed = false
      end

      def scenario_steps
        steps
      end
    end

    class ScenarioOutline
      def scenario_tags
        @tags.tags
      end

      def not_executed!
        @executed = false
      end

      def scenario_steps
        steps
      end

      def force_invoke!
        examples_array.each { |examples| examples.force_invoke! }
      end
    end

    class StepCollection
      def force_invoke!
        @steps.each{|step_invocation| step_invocation.force_invoke!}
      end
    end

    class StepInvocation
      def force_invoke!
        @skip_invoke = false
      end
    end

    class Step
      def force_invoke!
        @skip_invoke = false
      end
    end
  end
end

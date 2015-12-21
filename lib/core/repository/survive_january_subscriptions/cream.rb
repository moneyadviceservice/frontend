module Core::Repository
  module SurviveJanuarySubscriptions
    class Cream < Core::Repository::Base
      def register(email)
        if ::Cream::ClientV2.new.subscribe_to_survive_january(email)
          true
        else
          raise 'Cream count not subscribe to survive january'
        end
      end
    end
  end
end

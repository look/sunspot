module Sunspot
  module Query
    class MoreLikeThis < Query
      def initialize(obj)
        @obj = obj
      end

      def to_params
        setup = Setup.for(@obj.class)
        {
          :q => "id:\"#{Adapters::InstanceAdapter.adapt(@obj).index_id}\"",
          # FIXME: Will only text fields be used as the basis for MoreLikeThis queries?
          "mlt.fl" => setup.more_like_this.map { |f| "#{f}_text" }.join(",")
        }
      end
    end
  end
end


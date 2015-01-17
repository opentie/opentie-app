# spec is spec/models/request_spec

module OpentieCore
  class Request
    include Mongoid::Document

    belongs_to :project, inverse_of: :project

    def available?
    end

    field :commited, type: Boolean, default: false
    field :created_at, type: Time
    field :updated_at, type: Time

    class << self
      def subject(t)
        @subject = t
      end
      def application_period(t)
        @application_period = t
      end
      def declinable(t)
        @declinable = t
      end
      def in_charge_of(t)
        @in_charge_of = t
      end
    end
  end
end

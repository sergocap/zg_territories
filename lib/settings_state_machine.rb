module SettingsStateMachine
  extend ActiveSupport::Concern
  included do
    state_machine :state, initial: :draft do
      event :to_moderation do
        transition :draft => :moderation
      end

      event :to_published do
        transition :moderating => :published
      end

      event :to_draft do
        transition [:moderation, :published] => :draft
      end
    end
  end
end
module StateMachine
  module Integrations
     module ActiveModel
        public :around_validation
     end
  end
end

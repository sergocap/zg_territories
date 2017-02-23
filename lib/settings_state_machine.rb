module SettingsStateMachine
  extend ActiveSupport::Concern
  included do
    state_machine :state, initial: :draft do
      after_transition any => :draft do |object, transition|
        # послать письмо через апиху
      end

      event :to_moderation do
        transition :draft => :moderation
      end

      event :to_published do
        transition [:moderation, :draft] => :published
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

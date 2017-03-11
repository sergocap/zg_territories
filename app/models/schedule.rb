class Schedule < ApplicationRecord
  has_many   :breaks, dependent: :destroy
  belongs_to :organization
  accepts_nested_attributes_for :breaks, :reject_if => :all_blank, :allow_destroy => true

  def get_mode
    unless free
      str = "#{from.strftime("%H:%M")+ ' - ' + to.strftime("%H:%M")} #{mode_days}"
      if breaks.any?
        array = []
        breaks.each do |brea|
          array << "#{brea.from.strftime('%H:%M') + ' - ' + brea.to.strftime('%H:%M')}"
        end
        str_breaks = " (Перерывы #{array.join(', ')})"
        str = str + str_breaks if breaks.present?
      end
    else
      str = "Выходные  #{mode_days}"
    end
    str
  end

  def days_array
    %w(monday tuesday wednesday thursday friday saturday sunday)
  end

  def mode_days
    array = []
    days_array.each do |day|
      if self.attributes[day] == true
        array << I18n.t('activerecord.attributes.schedule.' + day)
      end
    end
    array.join(', ')
  end
end

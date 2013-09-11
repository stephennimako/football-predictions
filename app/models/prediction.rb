class Prediction < ActiveRecord::Base

  belongs_to :prediction_status
  belongs_to :user

  def to_s
    str = "#{self.class}:\n"
    instance_variables.each do |var|
      str += " %s: %s" % [var, instance_variable_get(var)]
    end
    str
  end

end

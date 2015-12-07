# implement alternative way to handle form validation error, via rescue_from ActiveRecord::RecordInvalid
# use Record.create! and @record.update_attributes! to update model
# usage:
#      extend RescueFromValidationError
#      rescue_from_validation_error('@model_name')
#      rescue_from_validation_error('@model_name', form: 'show')
module RescueFromValidationError

  # usage: rescue_from_validation_error('@user')
  def rescue_from_validation_error(instance_variable_name, options = {})
    rescue_from ActiveRecord::RecordInvalid, :with => :handle_validation_error

    define_method(:handle_validation_error) do |e|
      instance_variable_set(instance_variable_name, e.record)
      flash.now[:alert] = "Have validation errors"
      respond_to do |format|
        format.html { render :action => (e.record.new_record? ? options[:form] || 'new' : options[:form] || 'edit') }
      end
    end
  end

end
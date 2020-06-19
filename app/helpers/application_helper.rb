module ApplicationHelper

  def resource
     @resource ||= User.new
  end

  def resource_name
    :user
  end

  def resource_class
    User
  end

end

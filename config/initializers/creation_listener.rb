module CreationListener
  def inherited(subclass)
    super
    class_name = subclass.name
    subclass.after_commit :on => :create do
      Rails.logger.info "[#{Time.now.to_s}] Model created: '#{class_name}'"
    end
  end
end

ActiveRecord::Base.extend(CreationListener)

module Mongoid
  module History
    GLOBAL_TRACK_HISTORY_FLAG = "mongoid_history_trackable_enabled"

    mattr_accessor :tracker_class_name
    mattr_accessor :trackable_class_options
    mattr_accessor :modifier_class_name
    mattr_accessor :current_user_method

    def self.tracker_class
      @tracker_class ||= tracker_class_name.to_s.classify.constantize
    end

    def self.disable(&block)
      begin
        Thread.current[GLOBAL_TRACK_HISTORY_FLAG] = false
        yield
      ensure
        Thread.current[GLOBAL_TRACK_HISTORY_FLAG] = true
      end
    end

    def self.enabled?
      enabled = Thread.current[GLOBAL_TRACK_HISTORY_FLAG]
      enabled.nil? ? true : enabled
    end
  end
end

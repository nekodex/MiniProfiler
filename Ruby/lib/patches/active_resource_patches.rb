if defined?(ActiveResource)
  ActiveResource::Connection.class_eval do
    def request_with_mini_profiler(*arguments)
      # Rails.logger.info "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
      current = ::Rack::MiniProfiler.current
      current.skip_backtrace = true
      start = Time.now
      result = request_without_mini_profiler(*arguments)
      elapsed_time = ((Time.now - start).to_f * 1000).round(1)
      result.instance_variable_set("@miniprofiler_active_resource_id", ::Rack::MiniProfiler.record_active_resource(arguments[0], arguments[1], elapsed_time))
      result
    end
    alias_method_chain :request, :mini_profiler
  end
end

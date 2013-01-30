if (defined?(ActiveSupport) && defined?(ActiveSupport::Cache))
  ActiveSupport::Cache::Store.class_eval do
    def read_with_mini_profiler(name, options = nil)
      current = ::Rack::MiniProfiler.current
      start = Time.now
      result = read_without_mini_profiler(name, options)
      elapsed_time = ((Time.now - start).to_f * 1000).round(1)
      result.instance_variable_set("@miniprofiler_cache_id", ::Rack::MiniProfiler.record_cache("read", name, elapsed_time))
      result
    end
    def write_with_mini_profiler(name, value, options = nil)
      current = ::Rack::MiniProfiler.current
      start = Time.now
      result = write_without_mini_profiler(name, value, options)
      elapsed_time = ((Time.now - start).to_f * 1000).round(1)
      result.instance_variable_set("@miniprofiler_cache_id", ::Rack::MiniProfiler.record_cache("write", name, elapsed_time))
      result
    end
    alias_method_chain :read, :mini_profiler
    alias_method_chain :write, :mini_profiler
  end
end

# http://pivotallabs.com/users/alex/blog/articles/1232-basic-ruby-webapp-performance-tuning-rails-or-sinatra-

class Marker
  def self.mark(msg, logger = nil)
    if logger.nil?
      buffered_logger = ActiveSupport::BufferedLogger.new(File.join(Sinatrails.root, "log/#{ENV['RACK_ENV']}.log"))
      buffered_logger.auto_flushing = 10
      ActiveRecord::Base.logger = buffered_logger
      logger = ActiveRecord::Base.logger
    end

    start = Time.now
    logger.info("#{start} --> starting #{msg} from #{caller[2]}:#{caller[1]}")
    result = yield
    finish = Time.now
    logger.info("#{finish} --< finished #{msg} --- #{"%2.3f sec" % (finish - start)}\n\n\n")
    result
  end
end

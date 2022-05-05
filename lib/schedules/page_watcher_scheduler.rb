require_relative '../../lib/modules/scrapper/growth_page_watcher'

class PageWatcherScheduler
  def initialize
    @page_watcher = GrowthPageWatcher.new
  end

  def verify
    return unless notification_conditional

    available = @page_watcher.verify

    "#{message_header} #{GrowthPageWatcher::WATCHED_PAGE}" if available
  end

  def message_header
    "🏋🏋🏋 \n A página observada foi atualizada!\n\n\n"
  end

  def notification_conditional
    !File.exist?('tmp/page_watcher_notification.txt')
  end
end

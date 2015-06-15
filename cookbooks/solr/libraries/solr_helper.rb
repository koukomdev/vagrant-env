require 'net/http'
require 'uri'

module SolrHelper
  INTERVAL = 1.freeze

  def wait_until_bootup(solr_uri)
    checker = BootupChecker.new(solr_uri)
    sleep(INTERVAL) until checker.bootup?
  end

  class BootupChecker
    OK_STATUS = 200.freeze
    MAX_RETRY = 100.freeze

    def initialize(solr_uri)
      @counter = 0
      @url = URI.parse(solr_uri.to_s)
      @req = Net::HTTP::Get.new(@url.path)
    end

    def bootup?
      @counter += 1
      __log("count: #{@counter}")
      raise "solr boot check retry limit" if @counter > MAX_RETRY

      res = _curl
      unless res
        __log("server response nil")
        return false
      end

      __log("response code: #{res.code.to_i}")
      return res.code.to_i == OK_STATUS
    end

    private
    def _curl
      # Solr 再起動中は Connection Refused が返り RuntimeError になるが、
      # ここではリトライしたいため明示的に rescue nil している。
      res = Net::HTTP.start(@url.host, @url.port) {|http|
        http.request(@req)
      } rescue nil
      return res
    end

    # ロギングしつつデバッグ用に p する
    def __log(log)
      Chef::Log.info(log.to_s)
      p log.to_s
    end
  end
end

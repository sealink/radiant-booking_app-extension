class EcomEngine::Version

  def initialize(url)
    @url = url
  end

  def value
    return cache if cache_exists?
    read_and_cache
  end

  private

  def read_and_cache
    read.tap { |value|
      cache_store.write cache_key, value, expires_in: cache_expires_in
    }
  end

  def read
    response = version_response
    return '' unless response.is_a? Net::HTTPSuccess
    response.body.strip
  end

  def version_response
    Net::HTTP.get_response URI.parse(version_url)
  end

  def version_url
    "#{@url}/version.txt"
  end

  def cache_exists?
    not cache.nil?
  end

  def cache
    cache_store.read cache_key
  end

  def cache_store
    Rails.cache
  end

  def cache_key
    "#{cache_key_prefix}:#{@url}"
  end

  def cache_key_prefix
    :ecom_engine_version
  end

  def cache_expires_in
    expires_in = ENV['ECOM_ENGINE_VERSION_CACHE_EXPIRES_IN']
    return expires_in.to_i if expires_in.present?
    30
  end
end

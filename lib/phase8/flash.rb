class Flash
  def initialize(req)
    flash = req.cookies.find { |cookie| cookie.name == "_rails_lite_app_flash" }
    @flash_old = flash ? JSON.parse(flash.value) : {}
    @flash_new = {}
  end

  def [](value)
    @flash_old[value] || @flash_old[value.to_s] ||
    @flash_new[value] || @flash_new[value.to_s]
  end

  def []=(key, value)
    @flash_new[key] = value
  end

  def store_flash(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app_flash', @flash_new.to_json)
  end

  def now
    @flash_old
  end
end

require 'webrick'
require_relative '../lib/phase8/controller_base'
require 'byebug'
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

class MyController < Phase8::ControllerBase
  def go
    if @req.path == "/now"
      flash.now[:now_test] = "Flash.now testing..."
      render :flash_show
    elsif @req.path == "/blank"
      render :flash_show
    else
      flash[:test] = "Flash testing..."
      redirect_to("/blank")
    end
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  MyController.new(req, res).go
end

trap('INT') { server.shutdown }
server.start

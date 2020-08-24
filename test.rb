require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'try.html.erb')
server.mount('/try_one.cgi', WEBrick::HTTPServlet::CGIHandler, 'try_one.rb')
server.mount('/try_two.cgi', WEBrick::HTTPServlet::CGIHandler, 'try_two.rb')
server.start

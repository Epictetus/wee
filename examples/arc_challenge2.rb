#
# Implementation of the Arc Challenge using Wee.
#
# By Michael Neumann (mneumann@ntecs.de)
#
# http://onestepback.org/index.cgi/Tech/Ruby/ArcChallenge.red
#

$LOAD_PATH.unshift "../lib"
require 'rubygems'
require 'wee'
require "wee/conversation"

class Wee::IO
  def initialize(component)
    @component = component
  end

  def ask
    @component.display do |r|
      r.text_input.callback {|text| answer(text)}
      r.submit_button.value("Enter")
    end 
  end

  def pause(text)
    @component.display {|r| r.anchor.callback { answer }.with(text) }
  end

  def tell(text)
    @component.display {|r| r.text text.to_s }
  end
end

class Conversation < Wee::Task
  def go
    io = Wee::IO.new(self)
    text = io.ask
    io.pause("click here")
    io.tell("You said: #{text}")
  end
end

Wee.runcc(Conversation) if __FILE__ == $0
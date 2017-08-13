# IRB customizations shamelessly stolen from: 
# https://github.com/sdball/dotfiles
# https://github.com/janlelis/fancy_irb
# ruby 1.8.7 compatible
require 'rubygems'
require 'irb/completion'
require 'irbtools'

require 'fancy_irb'
DEFAULT_OPTIONS = {
  :rocket_mode     => true,       # activate or deactivate #=> rocket
  :rocket_prompt   => '#=> ',     # prompt to use for the rocket
  :result_prompt   => '=> ',      # prompt to use for normal output
  :unicode_display_width => true, # set to false if you don't want to check for proper
                                  # string width for better performance
  :colorize => {                  # colors hash. Set to nil to deactivate colors
    :rocket_prompt => [:blue],
    :result_prompt => [:blue],
    :input_prompt  => [:green],
    :irb_errors    => [:red, :clean],
    :stderr        => [:red, :bright],
    :stdout        => nil,
    :input         => nil,
   },
}
FancyIrb.start DEFAULT_OPTIONS

# interactive editor: use vim from within irb
begin
  require 'interactive_editor'
rescue LoadError => err
  warn "Couldn't load interactive_editor: #{err}"
end

IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => "irb> ",
  :PROMPT_S => "%l>> ",
  :PROMPT_C => ".. ",
  :PROMPT_N => ".. ",
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM
IRB.conf[:AUTO_INDENT] = true

# irb history
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irbhistory")

# load .railsrc in rails environments
railsrc_path = File.expand_path('~/.irbrc_rails')
if ( ENV['RAILS_ENV'] || defined? Rails ) && File.exist?( railsrc_path )
  begin
    load railsrc_path
  rescue Exception
    warn "Could not load: #{ railsrc_path } because of #{$!.message}"
  end
end

class Object
  def interesting_methods
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end
end

module StyleComment

    module Styles
	    
	    #list of all the comment styles
	    LIST = [:hyphen_block]

	    #makes sure every comment line has a line ending
	    def self.ensure_newlines(comment_lines)
		comment_lines.map do |line|
		     line << "\n" unless line[-1].eql? "\n"
		end
	    end

	    #-------
	    # hyphen-block
	    # ------
	    def self.hyphen_block(comment_lines)

		build = ->(n) { '-' * n }
		opening = "##{build[8]}\n" 

		comment_lines.map! do |line|
		    line = line.sub('#','').strip.chomp
		    line = "#| #{line}"
		end

		closing = "##{build[8]}\n"
		[opening, ensure_newlines(comment_lines), closing].join ''

	    end

    end

    class Styler

	    def initialize(file_path, options = {})
		@file = file_path
		@options = options
		@options[:style] ||= :hyphen_block
		    
	    end

	    #styles the comments in the file with a options[:style] (defaults to :hyphen_block)
	    def style_it

		File.open( @file, "r" ) do |input|
		    File.open( "#{File.dirname(@file)}/sc_#{File.basename(@file)}" , "w") do |output|
			    
			comment_lines = []
			input.readlines.each do |line|
			    if line[/\S/] == "#"
				    comment_lines << line
			    elsif not comment_lines.empty?
				    line = Styles.send( @options[:style],comment_lines )
				    comment_lines.clear
				    output << line
			    else
				    output << line
			    end
			end

		    end
		end

	    end
    end
end
    
#handles the shell invokes
file = ARGV.shift
options = {}
if ARGV
    ARGV.each do |arg|
       option, value = arg.split('=')
       option = option.gsub('-','').to_sym
       value = value.to_sym
       options[option] = value
       puts options[option]
    end
end

styler = StyleComment::Styler.new( file, options ) 
styler.style_it

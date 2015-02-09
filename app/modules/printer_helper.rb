module PrinterHelper

  def print_what_to_do
    puts 'It is best for u if u do:'
    puts tell_me_what_to_do
    puts self.class::BREAK_LINE
  end

  def print_welcome
    puts "Conference room about next decision of #{actual_user}"
  end
end
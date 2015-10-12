class Report
  def initialize(ledger)
    @balance          = ledger.inject(0) {|sum, (k,v)| sum += v }
    @credits, @debits = ledger.partition {|k,v| v > 0 }
  end
  
  attr_reader :balance, :credits, :debits
  
  def formatted_output
    "Current Balance: #{balance}\n\n" +
    "Credits:\n\n#{formatted_line_items(credits)}\n\n" +
    "Debits:\n\n#{formatted_line_items(debits)}"
  end
  
  def formatted_line_items(items)
    items.map {|k,v| "#{k}: #{'%.2f' % v.abs}" }.join("\n")
  end
end

ledger = [ ["Deposit Check #123", 500.15],
           ["Fancy Shoes",       -200.25],
           ["Fancy Hat",          -54.40],
           ["ATM Deposit",       1200.00],
           ["Kitteh Litteh",       -5.00] ]

report = Report.new(ledger)
puts report.formatted_output

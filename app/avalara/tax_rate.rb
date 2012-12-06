module Avalara
  include 'spree/calculators'
  class TaxRate < Spree::TaxRate



    def adjust(order, response)
      order.adjustments.create({:amount => response.total_tax,
                                :source => self,
                                :originator => self,
                                :locked => true,
                                :label => "Sales Tax"}, :without_protection => true)
    end

    def self.calculator
      Avalara::MockCalc
    end
  end


  class MockCalc < Calculator
    preference :amount, :decimal, :default => 0
    attr_accessible :preferred_amount


    def self.amount
      0.00
    end

    def self.description
      "Avalara mock calculator"
    end

    def compute(object=nil)
    end
  end




end
# This is a reimplementation of the tests of this kata:
# http://codekata.com/kata/kata09-back-to-the-checkout/
# Original implementation by Dave Thomas
require './Kata09.rb'

RSpec.describe CheckOut do
  let(:rules) {
    price = {
      A: {
        price: 50,
        special_price: {
          quantity: 3,
          price: 130
        }
      },
      B: {
        price: 30,
        special_price: {
          quantity: 2,
          price: 45
        }
      },
      C: {
        price: 20
      },
      D: {
        price: 15
      }
    }
  }

  it 'incremential scanning on the same bill' do
    checkout = CheckOut.new(rules)
    
    expect(checkout.total).to eq(0)

    checkout.scan('A')
    expect(checkout.total).to eq(50)

    checkout.scan('B')
    expect(checkout.total).to eq(80)

    checkout.scan('A')
    expect(checkout.total).to eq(130)

    checkout.scan('A')
    expect(checkout.total).to eq(160)

    checkout.scan('B')
    expect(checkout.total).to eq(175)
  end

  def total_of(items)
    checkout = CheckOut.new(rules)
    items.each do |item|
      checkout.scan(item)
    end
    checkout.total
  end

  it 'checking total of separate bills' do
    expect(total_of([])).to eq(0)
    expect(total_of(%w(A))).to eq(50)
    expect(total_of(%w(A B))).to eq(80)
    expect(total_of(%w(C D B A))).to eq(115)

    expect(total_of(%w(A A))).to eq(100)
    expect(total_of(%w(A A A))).to eq(130)
    expect(total_of(%w(A A A A))).to eq(180)
    expect(total_of(%w(A A A A A))).to eq(230)
    expect(total_of(%w(A A A A A A))).to eq(260)

    expect(total_of(%w(A A A B))).to eq(160)
    expect(total_of(%w(A A A B B))).to eq(175)
    expect(total_of(%w(A A A B B D))).to eq(190)
    expect(total_of(%w(D A B A B A))).to eq(190)
  end
end

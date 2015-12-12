
require "short_scale_nums/version"
require "QuadrillionOrBiggerError"
module ShortScaleNums

  # NUMERALS is an array variable that contains the instances
  # of Million, Billion, Trillion, Quadrillion
  NUMERALS  = (6..15).step(3).to_a.map{|x| 10 ** x}

  # Responsible for transforming the numbers to the targeted
  # form ex input: 1000000 output: 1M
  # * *Args*    :
  # +num+:: number that should be transformed ex: 1000000
  # * *Returns* :
  #   - the prettified number format ex: 1M
  def prettified_number(num)
    sign = sign_creator(num)
    num  = num.to_i.abs
    return num.to_s if NUMERALS.first > num or NUMERALS.last <= num
    NUMERALS.each do |short_scale|
      if short_scale >= num
        nums_arr = break_number(num,short_scale)
        break "#{sign}#{build_string(nums_arr,num)}"
      end
    end
  end

  # Responsible for breaking the number to the targeted
  # form ex input: 2500000,1000000 output: [2,5]
  # * *Args*    :
  # +num+:: number that should be transformed ex: 2500000
  # +short_scale+:: element from NUMERALS ex: 1000000
  # * *Returns* :
  #   - array with the [2,5]
  def break_number(num,short_scale)
    first_slice = (num.to_s.size - short_scale.to_s.size ) if num == short_scale
    first_slice = (num.to_s.size - (short_scale.to_s.size - 3) ) if num < short_scale
    first = num.to_s.slice(0..first_slice)
    second = num.to_s.slice(first.size..num.to_s.size)[0]
    return first,second
  end

  # Responsible for transforming the numbers to the targeted
  # form ex input: [2,5] output: 2.5M
  # * *Args*    :
  # +arr+:: array with two elements ex: [2,5]
  # +num+:: element from NUMERALS ex: 1000000
  # * *Returns* :
  #   - the prettified number format ex: 1M
  def build_string(arr,num)
    "#{truncation(arr)}#{abbr(num)}"
  end

  # Responsible for transforming the numbers to the targeted
  # number form without abbreviation ex input: 1000000 output: 1
  # * *Args*    :
  # +arr+:: number that should be transformed ex: 1000000
  # * *Returns* :
  #   - the prettified number without abbreviation ex: 1
  def truncation(arr)
    return "#{arr.join(".")}" if arr.last.to_i > 0
    "#{arr.first}"
  end

  # Responsible for transforming the numbers to the abbreviations
  # without their numbers ex input: 1000000 output: M
  # * *Args*    :
  # +num+:: element from NUMERALS ex: 1000000
  # * *Returns* :
  #   - the abbreviation of the number ex: M
  # * *Raises* :
  #   - QuadrillionOrBiggerError if the value of the number is equal
  #     or bigger than Quadrillion
  def abbr(num)
    raise QuadrillionOrBiggerError.new(num) if NUMERALS[3] <= num
    return 'M' if NUMERALS[1] >  num
    return 'B' if NUMERALS[2] >  num
    return 'T' if NUMERALS[3] >  num
  end

  def sign_creator(num)
    "-" if negative?(num)
  end

  def negative?(num)
    num < 0
  end

end

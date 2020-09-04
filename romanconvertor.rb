def validateRomanNumber(romanNumber)
    #; This takes care of both invalid cases, lowercase characters, and 
    #; characters that aren't a part of this list
    validChars = ["I", "V", "X", "L", "C", "D", "M"]
    romanNumber.each_char { |c|
        if ! (validChars.include? c)
            return false
        end
    }
    return true
end

def roman_mapping
    {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
end

def fromRoman(romanNumber)

    #; Ensure roman number contains valid characters
    if ! (validateRomanNumber(romanNumber))
        raise TypeError
    end
    result = 0
    str = romanNumber
    roman_mapping.values.each do |roman|
        while str.start_with?(roman)
          result += roman_mapping.invert[roman]
          str = str.slice(roman.length, str.length)
        end
    end
    result
end

def toRoman(arabicNumber)
    
    #; Ensure arabic number in bounds
    if (arabicNumber < 1) or (arabicNumber > 3999)
        raise RangeError
    end

    roman_mapping.reduce(number: arabicNumber, result: []) do |state, (divisor, letter)|
        letter_multiplier, remainder = state[:number].divmod(divisor)
        new_result = state[:result] + [letter * letter_multiplier]
        {number: remainder, result: new_result}
    end[:result].join
end
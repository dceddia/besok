module SmallID
    CHARS = %w{0 1 2 3 4 5 6 7 8 9} +
            %w{a b c d e f g h j k m n o p q r s t v w x y z } +
            %w{A B C D E F G H J K L M N O P Q R S T V W X Y Z }
    BASE = CHARS.length

    def SmallID.create(length = nil, number = nil)
        min = length ? (BASE ** (length - 1)) : 0
        max = length ? (BASE ** length) : 2**32
        number ||= rand(max - min) + min
        result = ""
        return result + CHARS[0] if number == 0
        while number > 0
            rem = number % BASE
            result += CHARS[rem]
            number = (number - rem) / BASE
        end
        result
    end
end

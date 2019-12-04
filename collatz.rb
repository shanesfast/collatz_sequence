require 'benchmark'

# Finds the length of a Collatz Sequence without building it
def collatz_length(number)
  sequence_length = 1
  
  while number != 1
    number.even? ? number = (number / 2) : number = (3 * number) + 1
    sequence_length += 1
  end

  sequence_length
end

# Builds a numbers Collatz Sequence and returns it.
def collatz_sequence(number)
  sequence = [number]

  while number != 1
    number.even? ? number = (number / 2) : number = (3 * number) + 1
    sequence.push(number)
  end

  sequence
end

# Keeps track of the longest Collatz Sequence for all given integer inputs
longest = { length: 1, digit: 1, sequence: 1 }
n = 1

time = Benchmark.measure {
  while n <= 1_000_000
    collatz = collatz_sequence(n)
    if collatz.length > longest[:length]
      longest[:length] = collatz.length
      longest[:digit] = n
      longest[:sequence] = collatz
    end
    n += 1
  end

  puts "\nThe longest Collatz Sequence for an integer input between 1 and 1,000,000 
  is the number #{longest[:digit]} with a length of #{longest[:length]}!"
  
  puts "\n----------"
  
  puts "\nThe sequence for #{longest[:digit]} is: \n\n #{longest[:sequence]}"
  
  puts "\n----------\n"
}

puts time.real
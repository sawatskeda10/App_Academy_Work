# ### Instructions
# # ------------------------------------------------------------------------------
# #
# # You have 45 minutes for this assessment. Don't spend too much time on any one
# # problem. Move on if you get stuck.
# #
# # To run the assessment, navigate to its location at the command line. You can
# # then run `ruby practice_assessment.rb`. Once you have completed the assessment,
# # everything should print `true` when you run the file.
# #
# # This assessment is strictly closed notes. No paper notes and no internet! You
# # are welcome and encouraged to use pry for debugging.
# #
# # Look at the test cases below each problem before you approach it. Make sure
# # you understand what each problem is asking.
# #
# # ** Do not share this assessment or post it publicly. We take violations
# # very seriously. **
#
# # ------------------------------------------------------------------------------
#
# ### Missing Numbers
# #
# # Given an array of unique integers ordered from least to greatest, write a
# # method that returns an array of the integers that are needed to
# # fill in the consecutive set.
#
def missing_numbers(nums)
	sorted = nums.sort

	(sorted.first..nums.last).to_a - sorted
end

puts "-------Missing Numbers-------"
puts missing_numbers([1, 3]) == [2]
puts missing_numbers([2, 3, 7]) == [4, 5, 6]
puts missing_numbers([-5, -1, 0, 3]) == [-4, -3, -2, 1, 2]
puts missing_numbers([100, 103, 105]) == [101, 102, 104]
puts missing_numbers([0, 5]) == [1, 2, 3, 4]
#
# # ------------------------------------------------------------------------------
#
# ### Binary to Base 10
# #
# # Write a method that given a string representation of a binary number will
# # return that binary number in base 10.
# #
# # To convert from binary to base 10, we take the sum of each digit multiplied by
# # two raised to the power of its index. For example:
# #   1001 = [ 1 * 2^3 ] + [ 0 * 2^2 ] + [ 0 * 2^1 ] + [ 1 * 2^0 ] = 9
# #
# # You may NOT use the Ruby String class's built in base conversion method.
#
def base2to10(binary)
	int = binary.split(//).map(&:to_i)

	int.reverse.map.with_index {|n , i| n * (2 ** i)}.reduce(&:+)
end

puts "-------Binary to Base 10-------"
puts base2to10("10") == 2
puts base2to10("01") == 1
p base2to10("0111") == 7
puts base2to10("1100") == 12
puts base2to10("1010101") == 85

# ------------------------------------------------------------------------------

### My Select
#
# Hash#select passes each key-value pair of a hash to the block (the proc
# accepts two arguments: a key and a value). Key-value pairs that return true
# when passed to the block are added to a new hash. Key-value pairs that return
# false are not. Hash#select then returns the new hash.
#
# Write your own Hash#select method by monkey patching the Hash class. Your
# Hash#my_select method should have the functionailty of Hash#select described
# above.

class Hash

	def my_select(&prc)
		ret = {}
		self.each  { |k, v| ret[k] = v if prc.call(k, v)}
		ret
	end
end

puts "-------My Select-------"
h1 = { a: 100, b: 200 }
h2 = { a: 100, b: 200 }
h3 = { a: 100, b: 200, c: 300 }

puts h1.my_select { |key, value| value > 100 } == { b: 200 }
puts h2.my_select { |key, value| key != :b } == { a: 100 }
puts h3.my_select { |key, value| value == 300 } == { c: 300 }

# # ------------------------------------------------------------------------------
#
# ### My Merge
# #
# # Hash#merge takes a proc that accepts three arguments: a key and the two
# # corresponding values in the hashes being merged. Hash#merge then sets that
# # key to the return value of the proc in a new hash. If no proc is given,
# # Hash#merge simply merges the two hashes.
# #
# # Write a method with the functionality of Hash#merge. Your Hash#my_merge method
# # should optionally take a proc as an argument and return a new hash. If a proc
# # is not given, your method should provide default merging behavior.
#
class Hash

	def my_merge(hash, &prc)
    new_hash = {}

    if prc != nil
			hash.each do |k, v|
        if self.include?(k)
          new_hash[k] = prc.call(k, self[k], v)
        else
          new_hash[k] = hash[k]
        end
      end

      self.each { |k, v| new_hash[k] = self[k] unless new_hash.include?(k) }

      return new_hash

    else
      self.each { |k, v| new_hash[k] = self[k] unless new_hash.include?(k) }

      hash.each { |k, v| new_hash[k] = hash[k] }

      return new_hash
    end
	end
end

puts "-------My Merge-------"
h1 = { a: 10, b: 2 }
h2 = { c: 3, d: 4 }
h3 = { a: 5, e: 6 }

p h1.my_merge(h3) { |key, oldval, newval| newval - oldval } == { a: -5, b: 2, e: 6 }
p h1.my_merge(h3) == { a: 5, b:2, e: 6 }
p h1.my_merge(h3) { |key, oldval, newval| oldval } == { a: 10, b: 2, e: 6 }
#
# # ------------------------------------------------------------------------------
#
### Lucas Numbers
#
# The Lucas series is a sequence of integers that extends infinitely in both
# positive and negative directions.
#
# The first two numbers in the Lucas series are 2 and 1. A Lucas number can
# be calculated as the sum of the previous two numbers in the sequence.
# A Lucas number can also be calculated as the difference between the next
# two numbers in the sequence.
#
# All numbers in the Lucas series are indexed. The number 2 is
# located at index 0. The number 1 is located at index 1, and the number -1 is
# located at index -1. You might find the chart below helpful:
#
# Lucas series: ...-11,  7,  -4,  3,  -1,  2,  1,  3,  4,  7,  11...
# Indices:      ... -5, -4,  -3, -2,  -1,  0,  1,  2,  3,  4,  5...
#
# Write a method that takes an input N and returns the number at the Nth index
# position of the Lucas series.

def lucas_numbers(n)
	lucas = [-1, 2, 1]
  i = n
	
	 if n < 0
     until i == -1
       lucas.unshift(lucas[1] - lucas[0])
       i += 1
     end

     lucas.first
   else
     until i == 1
       lucas << lucas[-2] + lucas[-1]
       i -= 1
     end

     lucas.last
   end
end

puts "-------Lucas Numbers-------"
puts lucas_numbers(3) == 4
puts lucas_numbers(5) == 11
puts lucas_numbers(-4) == 7
puts lucas_numbers(-3) == -4
puts lucas_numbers(10) == 123
puts lucas_numbers(-11) == -199

# # ------------------------------------------------------------------------------
#
# ### Longest Palindrome
# #
# # A palindrome is a word or sequence of words that reads the same backwards as
# # forwards. Write a method that returns the longest palindrome in a given
# # string. If there is no palindrome longer than two letters, return false.
#

def longest_palindrome(string)
	string.length.downto(2).each do |i|
		string.chars.each_cons(i) do |substring|
			return substring.count if palindrome?(substring.join)
		end
	end

	false
end

def palindrome?(substring)
	substring == substring.reverse
end

puts "-------Longest Palindrome-------"
puts longest_palindrome("aaabbabbacccccc") == 7
puts longest_palindrome("palindrome") == false
puts longest_palindrome("minimumreviver") == 7
puts longest_palindrome("clairesaysamanaplanacanalpanama") == 21
puts longest_palindrome("1818471174") == 6

# # ------------------------------------------------------------------------------

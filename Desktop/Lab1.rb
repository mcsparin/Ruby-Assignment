# Assignment 1

# Part1: Hello World
class HelloWorldClass
	def initialize(name)
		@name = name.capitalize
    end
    def sayHi
        puts "Hello #{@name}!"
    end
end
hello = HelloWorldClass.new("jan")
#hello.sayHi

# Part2: Palindromes
def palindrome?(string)
	
	#Convert to lowercase (downcase) and remove nonword characters (gsub)
	forwardString=string.downcase.gsub(/\W/,"")
	
	#Reverse the order of the characters
	revString=forwardString.reverse

	#if forwardString is the same as revString then it is a palindrome
	if revString==forwardString then 
		return true
	else 
		return false
	end

end
#puts palindrome?("Rats live on no evil star?")

#Part3: Word Count
def count_words(string)
	#Split on word boundaries and delete elements that are nonword characters
	words=string.split(/\b/).delete_if{|word| word=~/\W/ }
#Need to add link to stack overflow site
	count=Hash.new(0)
	words.each{|word| count[word]+=1}
	return count
end
#puts count_words("doo! bee-- doo, bee doo")

#Part4: Rock Paper Scissors

#4a
class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end
 
def rps_game_winner(game)
    
    #Check to ensure only 2 players per game
    raise WrongNumberOfPlayersError unless game.length == 2
    
    #Assign first and second player/move to player1 and player2 respectively 
    player1=game[0]
   	player2=game[1]

   	#If both players play the same move then the first player is the winner
   	if player1[1].downcase==player2[1].downcase then 
   		return player1
   	#Player1 plays "Rock"
   	elsif player1[1].downcase== "r" then 
   		if player2[1].downcase=="s" then 
   			return player1
   		elsif player2[1].downcase=="p" then
   			return player2
   		end
   	#Player1 plays "Scissors"
   	elsif player1[1].downcase=="s" then
   		if player2[1].downcase=="p" then 
   			return player1
   		elsif player2[1].downcase=="r" then
   			return player2
   		end
   	#Player1 plays "Paper"
   	elsif player1[1].downcase=="p" then 
   		if player2[1].downcase=="r" then 
   			return player1
   		elsif player2[1].downcase=="s" then 
   			return player2
   		end
   	end
   	#If the program reaches this point without returning a winner, then
   	#raise NoSuchStrategyError because one of the strategies is invalid
   	raise NoSuchStrategyError
end
#print rps_game_winner([["Armando","p"],["Dave","R"]]) , "\n"

#4b
def rps_tournament_winner(tournament)
	
	#Determines the number of players in the tournament
	numPlayers=(tournament.flatten.length)/2
	
	#Uses the number of players to determine the number of rounds 
	#needed to find a single winner
	rounds=Math.log2(numPlayers).to_i
	
	#Flattens tournament array into list of player/strategy lists of 
	#length 2 by using a recursion level that is one less than the 
	#number of rounds
	currentRound=tournament.flatten(rounds-1)

	#Each iteration corresponds to a round of the tournament where 
	#the players that lose are eliminated and the winners move on
	#to the next round.  It loops until there is a single winner
	until currentRound.length<2 do 
		#nextRound is empty before any games are played in current round
		nextRound=[]
		numGames=currentRound.length/2
		#Determines the winner of each game for a given round. The
		#winner's player/strategy is added to nextRound
		for i in 0..numGames-1
			currentGame=currentRound.pop(2)
     		winner=rps_game_winner(currentGame)
			nextRound+=[winner]
		end
		#Upon completion of a round, currentRound is set equal to
		#nextRound and the next round begins
		currentRound=nextRound
	end
	#Retruns the player/strategy of the winner as a 1-dimensional array
	#of length2
	return currentRound.flatten
end

tournament=[

    [

        [ ["Armando", "P"], ["Dave", "S"] ],

        [ ["Richard", "R"],  ["Michael", "S"] ],

    ],

    [

        [ ["Allen", "S"], ["Omer", "P"] ],

        [ ["David E.", "R"], ["Richard X.", "P"] ]

    ]

]

print rps_tournament_winner(tournament), "\n"

#5 Anagrams

def combine_anagrams(words)
	anagrams=words.group_by{|word| word.downcase.chars.sort}.values 
end


print combine_anagrams(['Cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])

# 6 Glob Match 
def glob_match(filenames, pattern)
# http://ruby-doc.org/core-2.1.0/File.html#M000001
	return filenames.delete_if{|filename| !File.fnmatch(pattern,filename,File::FNM_DOTMATCH)}
end

 print glob_match(['part1.rb', 'part2.rb', 'part2.rb~', '.part3.rb.un~'], '*part*rb?*'), "\n"

#7a  Dessert Class
#https://gist.github.com/feiskyer/1964748
class Dessert
  attr_accessor :name
  attr_accessor :calories
  def initialize(name, calories)
    @name=name
    @calories=calories
  end
  
  def healthy?
     @calories<200 
  end
 
  def delicious?
    true
  end
end
#7b JellyBean 
class JellyBean < Dessert
  attr_accessor :flavor
  def initialize(name, calories, flavor)
    @name=name 
    @calories=calories
    @flavor=flavor
  end
  
  def delicious?
    if @flavor== "black licorice"
      false
    else
      true
    end
  end
end


 
a=JellyBean.new("a",232,"black licorice")
p a.delicious?
p a.healthy?
b=Dessert.new("black licorice",190)
p b.delicious?
p b.healthy?

#8 Foo Class
#https://gist.github.com/feiskyer/1964749 
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s
    # getter
    attr_reader attr_name
    attr_reader attr_name+"_history"
  
    class_eval %Q{     
        def #{attr_name}=(val)
          @#{attr_name} = val
          @#{attr_name}_history = [nil] if @#{attr_name}_history.nil?
          @#{attr_name}_history.push(val)
        end
        }
  end
end
 
class Foo 
 attr_accessor_with_history :bar 
end 
 
#f = Foo.new 
#f.bar = 1 
#f.bar = 2 
#p f.bar
#p f.bar_history # => if your code works, should be [nil,1,2] 

#9 Currency Conversion
#https://gist.github.com/feiskyer/1964749 
class Numeric
  @@currencies = {'dollar' => 1.0, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
 
  def method_missing(method_id) 
    singular_currency = to_singular(method_id)
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency] #converts to dollars
    else
      super
    end
  end
 
  def in(currency)
    singular_currency = to_singular(currency)
    if @@currencies.has_key?(singular_currency)
      self / @@currencies[singular_currency] #converts from dollars to argument passed to in()
    else
      super
    end
  end
 
  private
 
  def to_singular(word)
    word.to_s.gsub( /s$/, '')
  end
end

# puts 5.dollars.in(:euros) , 10.euros.in(:rupees)

# 10a
#https://gist.github.com/feiskyer/1964749 
class String
  def palindrome?
    # Calls palindrome? defined in question 2
    Object.send(:palindrome?, self)
  end
end
puts "***** 10a *****", "foo".palindrome?, "foof".palindrome?
#10b 
#https://gist.github.com/feiskyer/1964749 
module Enumerable
  def palindrome?
    self.collect{|x| x} == self.collect{|x| x}.reverse
  end
end
puts "***** 10b *****", [1,2,3,2,1].palindrome?, ["this", "does", "work", "does", "this"].palindrome?
 
#11
#https://gist.github.com/feiskyer/1964749 
class CartesianProduct
  include Enumerable
  
  attr_reader :l_enum, :r_enum
 
  def initialize(l_enum, r_enum)
    @l_enum = l_enum
    @r_enum = r_enum
  end
 
  def each
    self.l_enum.each {
      |l| self.r_enum.each {
        |r| yield [l, r]
      }
    }
  end
end

puts "***** 11 *****"
c = CartesianProduct.new([:a,:b], [4,5])

c.each { |elt| puts elt.inspect }

c = CartesianProduct.new([:a,:b], [])

c.each { |elt| puts elt.inspect }
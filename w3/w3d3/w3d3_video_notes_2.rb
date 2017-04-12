## Video 4 ##

pry > reload! # to reload after changes

# Basic Associations #

# Cat class has a foreign key for house id corresponding to House class primary key
#

class Cat < ActiveRecord::Base
  # def house
  #   House.find(self.house_id)
  # end

  # same functionality as above using belongs to and hash (no curly braces)
  # => called a belongs to macro
  belongs to :house,        # name on the method
    primary_key: :id,       # this is the key in the source table (houses)
    foreign_key: :house_id  # this is the corresponding key in current class
    class_name: 'House'     # name of class from which the data will return
end                         # => as string or symbol



class House < ActiveRecord::Base
  # def cats
  #   Cat.where(house_id: self.id) # this returns all cats who have that instance of
  # end                            # house's id (in an array)

  # same functionality as above using 'has many' and hash (no curly braces)
  # => called a 'has many' macro
  has many :cats            # name of methods
    primary_key: :id,       # this is the key in the source table (houses)
    foreign_key: :house_id  # this is the corresponding key in cats table
                            # => where the 'many' are stored
    class_name: 'House'     # name of class from which the data will return
end                         # => as string or symbol


# Additional benefits
# => can change contents of the table
pry > beach.cats = Cats.all  # reassigned all cats to beach house_id (setter method)

pry > ranch = House.first # gives [] (all cats had been reassigned)
pry > ranch << Cats.last # reassigns last cat to ranch house_id


## Video 4 ##

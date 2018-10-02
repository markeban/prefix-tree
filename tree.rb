class Tree

  attr_reader :letters_map

  def initialize
    @letters_map = ('a'..'z').to_a.each_with_object({}) do |letter, hash|
      hash[letter] = nil
    end
  end

  def add_word(word)
    add_letters(word.split(//))
  end

  def add_letters(letters)
    return @letters_map['complete'] = true if letters.empty?

    first_character = letters.shift
    if @letters_map[first_character]
      @letters_map[first_character].add_letters(letters)
    else
      new_tree = Tree.new
      new_tree.add_letters(letters)
      @letters_map[first_character] = new_tree
    end
  end
end

tree = Tree.new
tree.add_word("cat")
tree.add_word("carp")
